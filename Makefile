LATEXMK ?= latexmk
BUILD_DIR ?= build
PACKAGE := tikz-umld
EXAMPLES := classdiag componentdiag seqdiag statediag usecasediag umld-features full

.PHONY: all check manual examples release-doc release-examples release-archive ctan-archive clean

all: check

check: manual examples

manual:
	mkdir -p $(BUILD_DIR)/manual
	cd doc && TEXINPUTS=..: $(LATEXMK) -pdf -interaction=nonstopmode -halt-on-error \
		-output-directory=../$(BUILD_DIR)/manual tikz-umld-userguide.tex

examples:
	@set -e; for example in $(EXAMPLES); do \
		mkdir -p "$(BUILD_DIR)/examples/$$example"; \
		cd examples; \
		TEXINPUTS=..: $(LATEXMK) -pdf -interaction=nonstopmode -halt-on-error \
			-output-directory="../$(BUILD_DIR)/examples/$$example" "$$example.tex"; \
		cd ..; \
	done

release-doc: manual
	cp $(BUILD_DIR)/manual/tikz-umld-userguide.pdf doc/tikz-umld-userguide.pdf

release-examples: examples
	@set -e; for example in $(EXAMPLES); do \
		cp "$(BUILD_DIR)/examples/$$example/$$example.pdf" examples/; \
	done

release-archive: check release-doc release-examples
	rm -rf $(BUILD_DIR)/dist
	mkdir -p $(BUILD_DIR)/dist/$(PACKAGE)/doc/fig $(BUILD_DIR)/dist/$(PACKAGE)/examples
	cp README.md CHANGELOG.md LICENSE.md NOTICE.md Makefile tikz-umld.sty $(BUILD_DIR)/dist/$(PACKAGE)/
	cp doc/tikz-umld-userguide.tex doc/tikz-umld-userguide.pdf \
		doc/tikz-umld-doc-style.sty doc/tikz-umld-listings-style.sty \
		$(BUILD_DIR)/dist/$(PACKAGE)/doc/
	cp doc/fig/*.tikz $(BUILD_DIR)/dist/$(PACKAGE)/doc/fig/
	cp examples/*.tex examples/*.pdf $(BUILD_DIR)/dist/$(PACKAGE)/examples/
	tar -C $(BUILD_DIR)/dist -czf $(BUILD_DIR)/$(PACKAGE).tar.gz $(PACKAGE)

ctan-archive: release-archive

clean:
	$(LATEXMK) -C -output-directory=$(BUILD_DIR)/manual doc/tikz-umld-userguide.tex
	rm -rf $(BUILD_DIR)
