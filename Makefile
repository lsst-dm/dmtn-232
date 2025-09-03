BUILDDIR="_build"
.PHONY:
init:
	pip install tox pre-commit
	pre-commit install

.PHONY:
html: index.rst
	tox run -e html
	mv top_milestones.html $(BUILDDIR)/html
	cp blockschedule.* $(BUILDDIR)/html

.PHONY:
lint:
	tox run -e lint,linkcheck

.PHONY:
add-author:
	tox run -e add-author

.PHONY:
sync-authors:
	tox run -e sync-authors

.PHONY:
clean:
	rm -rf _build
	rm -rf .technote
	rm -rf .tox



# assumes pip install of requirement and milestones.requiremetns
# celeb uses fdue forecast dates
.PHONY:
index.rst:  milestones blockschedule.pdf
	python milestones/milestones.py --pmcs-data=milestones/data/pmcs/202507-ME.xls celeb --inc=Y --months=1 --table ; 
	@echo ".. image:: blockschedule.png" >> index.rst;
	@echo "  :alt: Block Schedule" >> index.rst;
	@echo "" >> index.rst;
	@echo "\`Download the PDF of this Block Schedule here. <./blockschedule.pdf>\`_" >> index.rst;
	@echo "" >> index.rst;
	@echo ".. include:: acronyms.rst" >> index.rst;
	
blockschedule.pdf: milestones
	python milestones/milestones.py blockschedule --start-date -20 
	python milestones/milestones.py blockschedule --start-date -20 --output blockschedule.png

acronyms.rst : myacronyms.txt skipacronyms.txt
	generateAcronyms.py -m rst -t "PMO LSST"  index.rst 

venv:
	python -m venv $(VENVDIR)
	( \
                . $(VENVDIR)/bin/activate; \
                pip install -r requirements.txt; \
                pip install -r milesotnes/requirements.txt; \
        )

