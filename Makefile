

help:
	@echo ""
	@echo "Recommended commands:"
	@echo "	make view-manual		Builds the user manual and starts a local webserver"
	@echo "	make view-cookbook		Builds the cookbook and starts a local webserver"
	@echo "	make view-api			Builds the API documentation and starts a local webserver"
	@echo "	make view-contao4		Builds the Contao 4 migration book and starts a local webserver"
	@echo ""
	@echo "Other commands:"
	@echo "	make build			Builds HTML version of all books"
	@echo "	make build-pdf			Builds PDFs for the user manual"
	@echo "	make validate			Builds books and validates for invalid HTML output"
	@echo "	make install			Installs latest GitBook and dependencies"
	@echo ""

view-manual: install
	@node_modules/.bin/gitbook serve ./manual

view-cookbook: install
	@node_modules/.bin/gitbook serve ./cookbook

view-api: install
	@node_modules/.bin/gitbook serve ./api

view-contao4:
	@node_modules/.bin/gitbook serve ./contao4-migration

build: install
	@node_modules/.bin/gitbook build ./manual
	@node_modules/.bin/gitbook build ./cookbook
	@node_modules/.bin/gitbook build ./api
	@node_modules/.bin/gitbook build ./contao4-migration

build-pdf: install install-python
	@npm install ebook-convert
	@node_modules/.bin/gitbook pdf ./manual ./manual.pdf

install:
	@echo "--> Installing GitBook and plugins..."
	@npm install gitbook-cli
	@node_modules/.bin/gitbook install ./manual
	@node_modules/.bin/gitbook install ./cookbook
	@node_modules/.bin/gitbook install ./api
	@node_modules/.bin/gitbook install ./contao4-migration
	@rm -rf manual/node_modules/gitbook-plugin-anchorjs
	@rm -rf cookbook/node_modules/gitbook-plugin-anchorjs
	@rm -rf api/node_modules/gitbook-plugin-anchorjs
	@rm -rf contao4-migration/node_modules/gitbook-plugin-anchorjs
	@git clone -b master https://github.com/aschempp/gitbook-plugin-anchorjs.git manual/node_modules/gitbook-plugin-anchorjs
	@git clone -b master https://github.com/aschempp/gitbook-plugin-anchorjs.git cookbook/node_modules/gitbook-plugin-anchorjs
	@git clone -b master https://github.com/aschempp/gitbook-plugin-anchorjs.git api/node_modules/gitbook-plugin-anchorjs
	@git clone -b master https://github.com/aschempp/gitbook-plugin-anchorjs.git contao4-migration/node_modules/gitbook-plugin-anchorjs

install-python:
	@echo "--> You must have Python virtualenv"
	@virtualenv python_modules

validate: build install-python
	@python_modules/bin/pip install html5validator
	@python_modules/bin/python2.7 python_modules/bin/html5validator --root manual/_book/            --ignore "gitbook/plugins" "element must have an" "A document must not include both" "Duplicate ID"
	@python_modules/bin/python2.7 python_modules/bin/html5validator --root cookbook/_book/          --ignore "gitbook/plugins" "element must have an" "A document must not include both" "Duplicate ID"
	@python_modules/bin/python2.7 python_modules/bin/html5validator --root api/_book/               --ignore "gitbook/plugins" "element must have an" "A document must not include both" "Duplicate ID"
	@python_modules/bin/python2.7 python_modules/bin/html5validator --root contao4-migration/_book/ --ignore "gitbook/plugins" "element must have an" "A document must not include both" "Duplicate ID"

deploy: validate build-pdf
