all : display.pdf
.PHONY : all



JavaMainClass= vu.cli.best.collexis.Search
RunParameters= "fp2 306112281"
DevHome= /home/huygen/BEST/display
NuwebHome= /home/huygen/BEST/display/nuweb
NuwebHtmlDir = /home/CLI/www/best/html/display
BinDir = /home/huygen/BEST/devroot/bin
PhpDir = /home/huygen/BEST/php
DevRoot = /home/huygen/BEST/devroot
SourceDir = $(DevRoot)/src
TargetDir = $(DevRoot)/obj
LibDir =  $(DevRoot)/lib
Packages= vu.cli.best.collexis
PackageDirs= vu/cli/best/collexis
WebDir= /home/CLI/www/best/display
JavaSourcePaths= $(patsubst %,$(SourceDir)/%,$(PackageDirs))
JavaDestPaths= $(patsubst %,$(TargetDir)/%,$(PackageDirs))
JavaFiles = \
    vu/cli/best/collexis/Search.java \
    vu/cli/best/collexis/ResultHandler.java \
  

JavaClassFiles = $(JavaFiles:%.java=  %.class)
JavaFullPaths = $(JavaFiles:%.java= $(SourceDir)/%.java)
JavaClassFullPaths = $(JavaClassFiles:%.class= $(TargetDir)/%.class)
ClassPath = $(JavasetLibs):$(ExternalClasses):$(TargetDir)
ExternalClasses = /home/huygen/BEST/collexis/javalib/createcluster.jar:/home/huygen/BEST/collexis/javalib/collexisclasses.jar:/usr/share/java/activation.jar
JarFile = $(LibDir)/vuclibest.jar
.SUFFIXES: .pdf .w .tex .html .aux .log .php

Echo                   = @echo
Copy                   = cp
MakeDir                = mkdir -p
Delete                 = rm -fr
WordCount              = wc
List                   = cat
Print                  = lpr
DocumentViewer         = xpdf
MakeOptions            = -k -s
WordCountOptions       = --lines
Empty                  =
Space                  = $(Empty) $(Empty)
JAVA_HOME = /usr/lib/jvm/java-1.5.0-sun/
JavaCompiler           = $(JAVA_HOME)/bin/javac
JavaArchiver           = $(JAVA_HOME)/bin/jar
JarSigner              = $(JAVA_HOME)/bin/jarsigner
JavadocGenerator       = $(JAVA_HOME)/bin/javadoc
JniCompiler            = $(JAVA_HOME)/bin/javah
RmiCompiler            = $(JAVA_HOME)/bin/rmic
JavaVM                 = $(JAVA_HOME)/bin/java
JRE                    = $(JAVA_HOME)/jre/lib/rt.jar
JavasetLibs            = $(JRE)
JavaRunOptions = -classpath $(ClassPath)

JavaCompilerOptions    = -d $(TargetDir) -classpath $(ClassPath) \
			 -sourcepath $(SourceDir) -deprecation
JavaCompile = $(JavaCompiler) $(JavaCompilerOptions)
JavaRun = $(JavaVM) $(JavaRunOptions) $(JavaMainClass) $(RunParameters)

FIGFILES=horseshoe annotatestate fileschema mainflow helpeditflow

FIGFILENAMES=$(foreach fil,$(FIGFILES), $(fil).fig)
PDFT_NAMES=$(foreach fil,$(FIGFILES), $(fil).pdftex_t)
PDF_FIG_NAMES=$(foreach fil,$(FIGFILES), $(fil).pdftex)
PST_NAMES=$(foreach fil,$(FIGFILES), $(fil).pstex_t)
PS_FIG_NAMES=$(foreach fil,$(FIGFILES), $(fil).pstex)

HTML_PS_FIG_NAMES=$(foreach fil,$(FIGFILES), $(NuwebHtmlDir)/$(fil).pstex)
HTML_PST_NAMES=$(foreach fil,$(FIGFILES), $(NuwebHtmlDir)/$(fil).pstex_t)
W2PDF=./w2pdf
 
%.eps: %.fig
	fig2dev -L eps $< > $@

%.pstex: %.fig
	fig2dev -L pstex $< > $@

.PRECIOUS : %.pstex
%.pstex_t: %.fig %.pstex
	fig2dev -L pstex_t -p $*.pstex $< > $@

%.pdftex: %.fig
	fig2dev -L pdftex $< > $@

.PRECIOUS : %.pdftex
%.pdftex_t: %.fig %.pstex
	fig2dev -L pdftex_t -p $*.pdftex $< > $@

$(NuwebHtmlDir)/%.pstex : %.pstex $(NuwebHtmlDir)/
	$(Copy) $< $@


$(NuwebHtmlDir)/%.pstex_t : %.pstex_t $(NuwebHtmlDir)/
	$(Copy) $< $@


$(TargetDir)/%.class : $(SourceDir)/%.java javadestdirs
	$(Echo) $@
	@$(JavaCompiler) $(JavaCompilerOptions) $<

%.class : $(PackageSourceDir)/%.java
	@$(MAKE) $(MakeOptions) $(PackageTargetDir)/$@


%.pdf : %.w $(W2PDF) $(PDF_FIG_NAMES) $(PDFT_NAMES)
	chmod 775 $(W2PDF)
	$(W2PDF) $*


$(NuwebHtmlDir) :
	$(MakeDir) $(NuwebHtmlDir)


$(LibDir) :
	$(MakeDir) $(LibDir)


$(BinDir) :
	$(MakeDir) $(BinDir)


$(PhpDir) :
	$(MakeDir) $(PhpDir)


javasourcedirs : display.w
	$(Echo) "mkdir: " $(JavaSourcePaths)
	$(MakeDir) $(JavaSourcePaths)
	touch javasourcedirs

javadestdirs :
	$(MakeDir) $(JavaDestPaths)
	touch javadestdirs

bibfile : display.aux /home/huygen/bin/mkportbib
	/home/huygen/bin/mkportbib display best,ie,ai,math,litprog

.PHONY : bibfile
display.pdf : display.w display.bib $(W2PDF) \
                  $(PDF_FIG_NAMES) $(PDFT_NAMES)
	chmod 775 $(W2PDF)
	$(W2PDF) display.w

$(NuwebHtmlDir)/display.w : display.w $(NuwebHtmlDir)/
	$(Copy) $< $@


$(NuwebHtmlDir)/display.bib : display.bib $(NuwebHtmlDir)/
	$(Copy) $< $@


/home/CLI/www/best/html/display/rapport3.4ht : /usr/share/texmf/tex/generic/tex4ht/report.4ht
	$(Copy) /usr/share/texmf/tex/generic/tex4ht/report.4ht /home/CLI/www/best/html/display/rapport3.4ht

/home/CLI/www/best/html/display/display.html :  $(NuwebHtmlDir)/ /home/CLI/www/best/html/display/display.w /home/CLI/www/best/html/display/rapport3.4ht \
                 $(HTML_PS_FIG_NAMES) $(HTML_PST_NAMES) /home/CLI/www/best/html/display/display.bib
	cd $(NuwebHtmlDir) && chmod 775 ./w2html
	cd $(NuwebHtmlDir) && ./w2html display.w

m4_display.w : a_display.w
	gawk '{gsub(/[\\][\$$]/, "$$");print}' a_display.w > m4_display.w

display.w : m4_display.w  inst.m4 texinclusions.m4
	m4 -P m4_display.w > display.w


pdf : display.pdf

html : /home/CLI/www/best/html/display/display.html

view : display.pdf
	$(DocumentViewer) display.pdf

print : display.pdf
	$(Print) display.pdf

run : 
	$(MAKE) $(MakeOptions) sources
	$(MAKE) $(MakeOptions) runjava

lib :
	@$(MAKE) $(MakeOptions) sources
	@$(MAKE) $(MakeOptions) javalib


runjava : $(JavaClassFullPaths)
	$(Echo) "Class files: " $(JavaClassFiles)
	$(Echo) "Class reqs: " $(JavaClassFullPaths)
	$(Echo) $(JavaRun)
	$(JavaRun)

javalib : $(JarFile)

$(JarFile) : $(JavaClassFullpaths) $(LibDir)
	@cd $(TargetDir); $(JavaArchiver) -cf $@ $(JavaClassFiles)

$(W2PDF) : display.w
	nuweb display.w

sources : display.w inst.m4 texinclusions.m4 \
          $(NuwebHtmlDir)/ $(BinDir) javasourcedirs $(LibDir)
	nuweb -t display.w
	chmod 775 /home/huygen/BEST/devroot/bin/getverdicts.php




