CXX=g++
CXXFLAGS= $(shell llvm-config --cxxflags --ldflags --system-libs --libs core)

SRCDIR=src
BUILDDIR=_build

SOURCES=$(shell find $(SRCDIR)/*.cpp)
OBJECTS=$(SOURCES:$(SRCDIR)/%.cpp=$(BUILDDIR)/%.o)

EXENAME=kaleidoscope

$(BUILDDIR)/$(EXENAME): $(OBJECTS)
	$(CXX) $(CXXFLAGS) -o $@ $^

$(BUILDDIR)/%.o: $(SRCDIR)/%.cpp
	mkdir -p $(BUILDDIR)
	$(CXX) $(CXXFLAGS) -c -o $@ $<

run: $(BUILDDIR)/$(EXENAME)
	$(BUILDDIR)/$(EXENAME)

.PHONY: clean
clean:
	rm -rf $(BUILDDIR)
