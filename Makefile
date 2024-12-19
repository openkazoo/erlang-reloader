PROJECT = reloader
SOURCES := $(wildcard src/*.erl)
MODULE_NAMES := $(sort $(foreach module,$(SOURCES),$(shell basename $(module) .erl)))
MODULES := $(shell echo $(MODULE_NAMES) | sed 's/ /,/g')
EBIN = ebin

.PHONY=compile
compile: $(EBIN) $(EBIN)/$(PROJECT).app

$(EBIN)/$(PROJECT).app:
	@erlc -v +debug_info -o $(EBIN) $(SOURCES)
	@sed "s/{modules,\s*\[\]}/{modules, \[$(MODULES)\]}/" src/$(PROJECT).app.src > $@

$(EBIN):
	@mkdir -p $(EBIN)

clean:
	@$(if $(wildcard ebin/*), rm ebin/*)
