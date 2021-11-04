CXX=g++

SRCDIR=src
BUILDDIR=_build

SOURCES=$(shell find $(SRCDIR)/*.cpp)
OBJECTS=$(SOURCES:$(SRCDIR)/%.cpp=$(BUILDDIR)/%.o)

EXENAME=kaleidoscope

$(BUILDDIR)/$(EXENAME): $(OBJECTS)
	$(CXX) -o $@ $^

$(BUILDDIR)/%.o: $(SRCDIR)/%.cpp
	mkdir -p $(BUILDDIR)
	$(CXX) -c -o $@ $<

run: $(BUILDDIR)/$(EXENAME)
	$(BUILDDIR)/$(EXENAME)

.PHONY: clean
clean:
	rm -rf $(BUILDDIR)
