
m4_define(m4_progname, `display')m4_dnl
m4_define(m4_webpagtitle, `Display')m4_dnl
m4_define(m4_webbackdoortitle, `Display -- achterdeur')m4_dnl
m4_define(m4_doctitle, `Display legal case information')m4_dnl
m4_define(m4_docdate, `Version~2 of \\ m4_latexdag \\ m4_time_of_day~h.')m4_dnl
m4_define(m4_author, `Paul Huygen (p.e.m.huygen@@cli.vu)')m4_dnl
m4_define(m4_subject, `BEST project')m4_dnl
m4_define(m4_mkportbib, `/home/huygen/bin/mkportbib')m4_dnl
m4_dnl
m4_dnl Development organisation
m4_dnl
m4_define(m4_devhome, `/home/huygen/BEST/display')m4_dnl
m4_define(m4_nuwebdir, m4_devhome`/nuweb')m4_dnl
m4_define(m4_devroot, `/home/huygen/BEST/devroot')m4_dnl
m4_define(m4_srcdir,  m4_devroot`/src')m4_dnl
m4_define(m4_libdir,  m4_devroot`/lib')m4_dnl
m4_define(m4_bindir,  m4_devroot`/bin')m4_dnl
m4_define(m4_phpdir,  `/home/huygen/BEST/php')m4_dnl
m4_dnl
m4_dnl     Packages
m4_dnl
m4_define(m4_bestpacknam,         `vu'$1`cli'$1`best')m4_dnl
m4_define(m4_collexispacknam, `vu'$1`cli'$1`best'$1`collexis')m4_dnl
m4_define(m4_packagename, m4_bestpacknam(`.'))m4_dnl
m4_define(m4_collexispackagename, m4_collexispacknam(`.'))m4_dnl
m4_define(m4_packagedir, m4_bestpacknam(`/'))m4_dnl
m4_define(m4_collexispackagedir,  m4_collexispacknam(`/'))m4_dnl
m4_dnl
m4_define(m4_rmplib, `/home/huygen/BEST/php/rmp.php')m4_dnl

m4_dnl
m4_dnl     Java
m4_dnl
m4_define(m4_javahome, `/usr/lib/jvm/java-1.5.0-sun/')m4_dnl
m4_define(m4_javajre, m4_javahome`/jre/lib/rt.jar')m4_dnl
m4_define(m4_packagejar, m4_bestpacknam(`'))m4_dnl
m4_dnl
m4_dnl Java libraries
m4_dnl
m4_define(m4_collexisjavalibpath, `/home/huygen/BEST/collexis/javalib')m4_dnl
m4_define(m4_extjar1, m4_collexisjavalibpath`/createcluster.jar')m4_dnl
m4_define(m4_extjar2, m4_collexisjavalibpath`/collexisclasses.jar')m4_dnl
m4_define(m4_javaxjavalibpath, `/usr/share/java')m4_dnl
m4_define(m4_extjar3, m4_javaxjavalibpath`/activation.jar')m4_dnl
m4_dnl
m4_dnl Source code documentation
m4_dnl
m4_define(m4_htmldocdir, `/home/CLI/www/best/html/display')m4_dnl
m4_define(m4_htmlsource, m4_htmldocdir`/'m4_progname`.w')m4_dnl
m4_define(m4_htmlbinfil, m4_htmldocdir`/'m4_progname`.dvi')m4_dnl
m4_define(m4_htmlbibfil, m4_htmldocdir`/'m4_progname`.bib')m4_dnl
m4_define(m4_htmltarget, m4_htmldocdir`/'m4_progname`.html')m4_dnl
m4_define(m4_4htfilsource, `/usr/share/texmf/tex/generic/tex4ht/report.4ht')m4_dnl
m4_define(m4_4htfildest, m4_htmldocdir`/rapport3.4ht')m4_dnl
m4_dnl
m4_dnl bibliography (bib files that can be reached with kpesewhich, without .bib extension)
m4_dnl
m4_define(m4_bibliographies, `best,ie,ai,math,litprog')m4_dnl
m4_dnl
m4_dnl Project website
m4_dnl
m4_define(m4_webrootdir,`/home/CLI/www')m4_dnl         Web root 
m4_define(m4_webrootURL,`http://cli.vu/')m4_dnl
m4_define(m4_grapdir, m4_webrootdir`/plaatjes')m4_dnl   pictures
m4_define(m4_grapURL, m4_webrootURL`/plaatjes')m4_dnl   
m4_define(m4_webdir, m4_webrootdir`/best/display')m4_dnl http location
m4_define(m4_webURL, m4_webrootURL`/best/display')m4_dnl http location
m4_define(m4_helpdir, m4_webdir`/help')m4_dnl            help info
m4_define(m4_helpURL, m4_webURL`/help')m4_dnl   
m4_define(m4_javascriptdir, m4_webrootdir`/javascripts')
m4_define(m4_javascriptURL, m4_webrootURL`/javascripts')
m4_define(m4_stylesheetname, `best.css')m4_dnl
m4_define(m4_stylesheetdir, m4_webdir`/css')m4_dnl
m4_define(m4_stylesheet, m4_stylesheetdir`'/m4_stylesheetname)m4_dnl
m4_define(m4_stylesheeturl, m4_webURL`/css'/`'m4_stylesheetname)m4_dnl
m4_define(m4_demowebpage, `/home/CLI/www/best/conceptodemo.php')m4_dnl
m4_dnl
m4_dnl Resources
m4_dnl
m4_dnl
m4_dnl Location of the ontology
m4_dnl
m4_define(m4_ontologyhost, `http://appia.rechten.vu.nl')m4_dnl
m4_define(m4_ontologyport, `8180')m4_dnl
m4_define(m4_ontologyname, `best')m4_dnl
m4_define(m4_repositoriesdir, `openrdf-sesame/repositories')m4_dnl Sesame 2
m4_define(m4_defaultnamespace, `http://www.owl-ontologies.com/OnrechtmatigeDaad.owl`#'')
m4_dnl
m4_dnl Namespaces and uri's
m4_dnl
m4_changecom(`\*',`*\')m4_dnl
m4_define(m4_nsbest, `http://www.best-project.nl/2008/04/layman#')m4_dnl
m4_define(m4_nsowl, `http://www.w3.org/2002/07/owl#')m4_dnl
m4_define(m4_nsrdf, `http://www.w3.org/1999/02/22-rdf-syntax-ns#')m4_dnl
m4_define(m4_nsrdfs, `http://www.w3.org/2000/01/rdf-schema#')m4_dnl
m4_define(m4_nsxsd, `http://www.w3.org/2001/XMLSchema#')m4_dnl
m4_changecom(`#')m4_dnl
m4_define(m4_querylanguage, `sparql')m4_dnl
m4_dnl
m4_dnl   Fingerprint/searchdoc texts
m4_dnl   the first version with 36 fingerprints files.
m4_define(m4_fingerprintdir,`/home/huygen/BEST/concepts')m4_dnl
m4_define(m4_fingerprinttextdir,`/home/huygen/BEST/concepts/texts')m4_dnl
m4_define(m4_fingerprintfil,`/home/huygen/BEST/concepts/fp$1')m4_dnl
m4_define(m4_fingerprintfiltrunk,`/home/huygen/BEST/concepts/fp')m4_dnl
m4_define(m4_nrofconcepts,`36')m4_dnl
m4_dnl
m4_dnl A later version. Many searchdocs are temporary placed in ...
m4_dnl m4_define(m4_searchdocdir,`/home/huygen/BEST/display/resources/searchdocs/all')m4_dnl
m4_define(m4_searchdocdir,`/home/huygen/BEST/concepts')m4_dnl
m4_dnl
m4_dnl Collexis stuff
m4_dnl
m4_define(m4_elisabethtweecollexionid, `306112281')m4_dnl
m4_define(m4_elisabethdriecollexionid, `1770783843')m4_dnl
m4_define(m4_tweenulnulachtcollexionid, `290498218')m4_dnl
m4_dnl
m4_dnl   Case-groups
m4_dnl
m4_define(m4_resourcesdir, m4_devhome`/resources')m4_dnl
m4_define(m4_verdictslist, m4_resourcesdir`/verdictslist')m4_dnl
m4_define(m4_casegrouplist, m4_resourcesdir`/casegroups')m4_dnl
m4_dnl
m4_dnl   Pseudo-rnldb
m4_dnl
m4_define(m4_rnldbdir, `/share2/data/rnldb')m4_dnl
m4_define(m4_uitspraaktextdir, `m4_rnldbdir/uitspraak/text')m4_dnl
m4_define(m4_uitspraakconcdir, `m4_rnldbdir/uitspraak/conc')m4_dnl
m4_define(m4_uitspraakstabdir, `m4_rnldbdir/uitspraak/stab')m4_dnl
m4_define(m4_sentencetablabel, `Sentences:')m4_dnl
m4_define(m4_sentencetablabellower, `sentences:')m4_dnl
m4_define(m4_pbtablabel, `ZParbegs:')m4_dnl
m4_define(m4_pbtablabellower, `zparbegs:')m4_dnl
m4_define(m4_petablabel, `ZParlengths:')m4_dnl
m4_dnl
m4_dnl   Concepts
m4_dnl
m4_define(m4_conceptdir, m4_devhome`/concepts')m4_dnl
m4_dnl
m4_dnl relevance  
m4_dnl
m4_define(m4_singleweighttresh, `100')m4_dnl
m4_define(m4_multiweighttresh, `50')m4_dnl

m4_dnl
m4_dnl Back-door  
m4_dnl
m4_define(m4_backdoordir, m4_webdir`/achterdeur')m4_dnl http location
m4_define(m4_backdoorURL, m4_webURL`/achterdeur')m4_dnl http location
m4_dnl
m4_dnl Tiny-MCE editor
m4_dnl
m4_define(m4_tinyMCEURL, `http://appia.rechten.vu.nl/tinymce/tiny_mce.js')m4_dnl
m4_dnl
m4_dnl Macro's for HTML creation.
m4_dnl
m4_dnl
m4_dnl css classes
m4_define(m4_conceptparnull,         `pnull'  )m4_dnl
m4_define(m4_conceptparone,          `pone'  )m4_dnl
m4_define(m4_conceptpartwo,          `ptwo'  )m4_dnl
m4_define(m4_conceptparthree,        `pthree')m4_dnl
m4_define(m4_conceptparonetwo,       `ponetwo'  )m4_dnl
m4_define(m4_conceptparonethree,     `ponethree'  )m4_dnl
m4_define(m4_conceptpartwothree,     `ptwothree'  )m4_dnl
m4_define(m4_conceptparonetwothree,  `ponetwothree'  )m4_dnl
m4_define(m4_conceptwordone,         `fone'  )m4_dnl
m4_define(m4_conceptwordtwo,         `ftwo'  )m4_dnl
m4_define(m4_conceptwordthree,       `fthree'  )m4_dnl
m4_define(m4_conceptwordonetwo,      `fonetwo'  )m4_dnl
m4_define(m4_conceptwordtwothree,    `ftwothree'  )m4_dnl
m4_define(m4_conceptwordonethree,    `fonethree'  )m4_dnl
m4_define(m4_conceptwordonetwothree, `fonetwothree'  )m4_dnl
m4_dnl
m4_dnl
m4_define(m4_white,          `#ffffff')m4_dnl
m4_define(m4_paleweakgreen,  `#ccffcc')m4_dnl
m4_define(m4_paleweakred,    `#ffcccc')m4_dnl
m4_define(m4_paleweakblue,   `#ccccff')m4_dnl
m4_define(m4_paleweakyellow, `#ffffcc')m4_dnl
m4_define(m4_paleweakmagenta,`#ffccff')m4_dnl
m4_define(m4_darkmagentav,   `#9900cc')m4_dnl, 'DMV', 'Dark Magenta-Violet'
m4_define(m4_paleweakcyan,   `#ccffff')m4_dnl
m4_define(m4_darkdullcyan,   `#339999')m4_dnl, 'DDC', 'Dark Dull Cyan' 
m4_define(m4_palegrey,       `#cccccc')m4_dnl
m4_define(m4_obscuregrey,    `#333333')m4_dnl, 'OG', 'Obscure Gray' 
m4_define(m4_green,          `#00ff00')m4_dnl
m4_define(m4_red,            `#ff0000')m4_dnl
m4_define(m4_blue,           `#0000ff')m4_dnl
m4_define(m4_lichtgeel,  `#f2ebba')m4_dnl
m4_define(m4_donkergeel, `#f2db00')m4_dnl
m4_define(m4_lichtblauw, `#92fcf8')m4_dnl
m4_define(m4_donkerblauw,`#2293f7')m4_dnl
m4_define(m4_lichtgroen, `#e3f2cf')m4_dnl
m4_define(m4_donkergroen,`#65e409')m4_dnl
m4_dnl
m4_dnl
m4_dnl resources
m4_dnl
m4_define(m4_tempdocdir, `/home/huygen/BEST/display/tempfiles')m4_dnl
m4_dnl
m4_define(m4_miscdir, `/home/huygen/BEST/misc')m4_dnl
m4_define(m4_legalesefil, `m4_miscdir/legalese.txt')m4_dnl
m4_dnl
m4_dnl Miscellaneous
m4_dnl
m4_define(m4_locale,`nl_NL.UTF-8')m4_dnl
m4_define(m4_maxactiveconcepts,`3')m4_dnl
m4_define(m4_filenamekeyword,`dispfil')m4_dnl
m4_define(m4_conceptnumkeyword,`concn')m4_dnl 20080807 For the *active* concepts
m4_define(m4_conceptidkeyword,`concept')m4_dnl 20080807 Alternative for m4_conceptnumkeyword
m4_define(m4_modekeyword,`mode')m4_dnl
m4_define(m4_selectionkeyword,`sel')m4_dnl
m4_define(m4_newlegaw,`@@new')m4_dnl
m4_define(m4_clusterkeyword,`cl')m4_dnl
m4_dnl
m4_dnl max times to compile with LaTeX.
m4_dnl
m4_define(m4_maxtexloops, `10')m4_dnl
m4_dnl
m4_dnl System-dependent definitions
m4_dnl
m4_define(m4_printpdf, `lpr '$1`.pdf')m4_dnl
m4_define(m4_viewpdf, `xpdf '$1`.pdf')m4_dnl
m4_define(m4_latex, `pdflatex '$1)m4_dnl
m4_dnl
m4_dnl Graphs
m4_dnl
m4_define(m4_bestlogo, m4_grapURL`'/best-logo.gif)m4_dnl
m4_define(m4_bestlogowidth, `80')m4_dnl
m4_define(m4_bestlogoheight, `120')m4_dnl
m4_dnl
m4_dnl Dimensions
m4_dnl
m4_define(m4_leftpanelwidth, `200px')m4_dnl
m4_define(m4_rightpanelwidth, `100px')m4_dnl
m4_dnl
m4_dnl Texts
m4_dnl
m4_define(m4_bannerheading, `Wat is mijn positie?')m4_dnl
m4_define(m4_bannersubheading, `Prototype')m4_dnl
m4_dnl
m4_dnl (style) things that probably do not have to be modified
m4_dnl
m4_changequote(`?',`!')m4_dnl
m4_define(m4_header, ?m4_esyscmd(date +'%Y%m%d at %H%Mh'| tr -d '\012'): Generated by nuweb from a_!m4_progname?.w!)m4_dnl
m4_define(m4_latexdag, ?m4_esyscmd(date +'\kdag{%d}{%m}{%Y}'| tr -d '\012')!)m4_dnl
m4_define(m4_time_of_day, ?m4_esyscmd(date +'%H:%M'| tr -d '\012')!)m4_dnl
m4_define(m4_index4ht, ?tex '\def\filename{{!m4_progname?}{idx}{4dx}{ind}} \input idxmake.4ht'!)m4_dnl
m4_changequote(?`!,?'!)m4_dnl
m4_dnl
m4_dnl Useful functions
m4_dnl
m4_define(m4_nieuwedir,
`@d create directories @{@%
mkdir -p $1
@| mkdir @}
')m4_dnl


m4_dnl The \textsc{url} of the page itself:
m4_define(m4_ikzelf, `$_SERVER["PHP_SELF"]')m4_dnl
m4_dnl m4_define(m4_pak_ikzelf, `<?php printf("$_SERVER[\"PHP_SELF\"]");?>')m4_dnl
