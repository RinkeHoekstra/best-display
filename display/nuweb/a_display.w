m4_include(inst.m4)m4_dnl
m4_define(m4_rlbl,
`if(file_exists(\$1)&&(\$handle = fopen(\$1, "rb"))){
  while(!feof(\$handle)){
    \$line=trim(fgets(\$handle));
    @< \$2 @>
  };
  fclose(\$handle);
} else {
    printf(" <p>\$3</p>\n ");
    return;
}'
)m4_dnl
m4_include(texinclusions.m4)m4_dnl
\begin{document}
\maketitle
\begin{abstract}
  This is the source code of a computer program to present legal
  verdicts with explanations
  to laymen. It is part of a project to provide layman with relevant
  documentation concerning a legal case in which they are involved and
  implements scheme developed by Wildeboer~\cite{wildeboer2007a}.
\end{abstract}
\tableofcontents

\chapter{Introduction}
\label{chap:introduction}

\section{About this document}
\label{sec:whatabout}

This document contains the source code of a program to present legal
verdicts with explanations to laymen. It is a part of the
\emph{\batna{} Establishment using Semantic web Technology} (\best)
(\href{http://www.best-project.nl}{\texttt{http://www.best-project.nl}})
project, which is a collaboration of the departments of Computer
Science and Law of the Vrije Universiteit Amsterdam. The project has
been granted by the Dutch Organization of Science (\textsc{nwo}) as a
Token~2000 project.

The source code has been written in the style of literate
programming~\cite{Knuth:1983:LP}, using the
Nuweb~\cite{Briggs:1993:NSL} tool. How this works is explained in the
appendix (\autoref{chap:translatedoc}). In short: the programmer produces
a document that describes the program. The description is illustrated
by pieces of program code. The nuweb tool extracts the code pieces and
writes them into source files that can be compiled or interpreted.


\section{The BEST project}
\label{sec:bestproject}

The goal of the \best{} project is, to provide computer-based support
for laymen who are involved in a legal procedure. Due to the high and
raising costs of the legal support that is necessary to pursue a legal
procedure before a legal court, alternative methods are developed to
settle legal conflicts, e.g.\ negotiation, mediation or arbitration.
These procedures will have the best chances to lead to settlements if
the parties have good knowledge about what would be going to happen if
the alternative procedure would be unsuccessful and the dispute would
have to be solved by a judge. Such information is called \batna{}
(Best Alternative to a Negotiated Agreement). The \best{} project aims
to provide laymen with legal verdicts and legal articles that contain
relevant information for the case of the user. It explains why the
provided information is relevant for the user.

\section{How the layman obtains her BATNA}
\label{sec:horseshoe}

It is envisioned that the to be developed computer tool works as
follows (figure~\ref{fig:horseshoe}):
\begin{figure}[hbtp]
  \centering
@%  \input{horseshoe.pdf_t}
  \includegraphics{horseshoe.fig}
  \caption{Scheme of the \batna{} tool to be developed. See text for
    explanation of the numbers. The part of the task that this program
  is oriented at is indicated with the dashed rectangle.}
  \label{fig:horseshoe}
\end{figure}

\begin{enumerate}
\item The user (layman seeking legal support) explains his case in an electronic document.
\item The computer analyses this document. The computer may enter into
  a dialog with the user.
\item The computer translates the information obtained from the user
  in user-oriented legal concepts (using a layman ontology).
\item The computer translates the user-oriented legal concepts into
  literature-oriented legal concepts (with a legal ontology).
\item The computers searches in legal databases (laws, articles about
  law and legal verdicts) for documents that contain information that
  is relevant for the legal concepts.
\item The computer presents the obtained documents to the user,
  together with an explanation and an abstraction/highlighting
  facility.
\end{enumerate}

\section{Ontology of concepts}
\label{sec:concepts}

The core of this project is the \emph{legal concept}, the
description/definition of a legal issue on which e.g.{} a legal
verdict is based. Examples of concepts are \qstring{Act or omission
violating an unwritten rule pertaining of proper social conduct} or
\qstring{Say over subordinates}~\cite{uijttenbroek2007a}.

The legal concepts are not single, unrelated objects, but they are
part of a large structure called an ontology. The ontology is a graph,
that contains concepts and their properties as nodes, and represents
their relationships as arrows.


\section{Resources}
\label{sec:resources}

The display program uses external resources to obtain information.
Information about concepts are obtained from an ontology in the
\href{http://www.openrdf.org}{Sesame} web-application. Information
about relevant legal verdicts are obtained from the data-mining
software Collexis. The texts of the verdicts is obtained from a
database.

\subsection{Ontology}
\label{sec:ontologyoverview}

In the current project an ontology has
been developed using the \textsc{rdf}\index{RDF} (Resource Description Framework, \href{http://www.w3.org/RDF/}{http://www.w3.org/RDF/}) ontology
language. The objects in the ontology and their relationships can be
retrieved using queries in a similar way as \textsc{sql} (Structured Query
Language) queries serve to retrieve data from databases. In this
program, we use the legal ontology to retrieve the following
information:

\begin{itemize}
\item The concepts that are specifications or generalisations of a
  given concept.
\item The explaining text of a concept.
\item The search document of a concept.
\item References to verdicts for which a concept is relevant.
\end{itemize}

The ontology is implemented in the \emph{Resource
  Description Framework} (\textsc{rdf}) language~\cite{rdfwww2008a}.
It is available as a Sesame~\cite{broekstra2002a} web-application and
can be consulted with standardised query-languages
e.g.~\sparql{}~\cite{sparql2008a} and
\serql{}~\cite{broekstra2003a}. In this document we will use
\sparql{}.

In section~\ref{sec:ontology-interface} an interface class is
developed that connects to the ontology

\subsection{Fingerprint}
\label{sec:fingerprint-overview}

One of the properties of a concept in the ontology is a
\emph{fingerprint}, with a related \emph{search document}. The search
document is a set of sentences that tend to be used by judges when
they argue about the concept. Figure~\ref{fig:causalityfp} is an example of a
fingerprint. The data-mining software
(cf.~\ref{sec:datamining-overview}) uses these sentences to find
verdicts for which the concept is important and in which the judge
argues about it. In our application, we use the sentences to recognise
and highlight the paragraphs in the verdict in which the argument
takes place.

\subsection{Database of verdicts}
\label{sec:verdictdb-overview}

For this project we use verdicts that have been published on-line by
the Dutch council of the judiciary on web-site
\href{www.rechtspraak.nl}{\texttt{www.rechtspraak.nl}}. The Counsil of
the Judiciary gave us permission to obtain the verdicts directly as
\textsc{xml} files from their repository. The programs in
\extref{rnlmysql}{http://cli.vu/best/pdf/rnlmysql.pdf}
process the \textsc{xml} files and create/maintain a Mysql database.

@%\begin{itemize}
@%\item A table that lists properties of each verdict.
@%\item Directories that contains for each verdict a file with the text.
@%\item Directories that contain for each verdict a file with a table of
@%  the words in the text.
@%\item Directories that contain for each verdict a similar file with
@%  known words only.
@%\item Directories that contain for each verdict a similar file with
@%  the stems of the words.
@%\item Directories that contain for each verdict a file with a table of
@%  the offsets of text-strings in the verdict that match phrases in
@%  fingerprints.
@%\end{itemize}

Currently the database contains the texts of about~100k verdicts.


\subsection{Data-mining software}
\label{sec:datamining-overview}

To recognise relevant verdicts, currently the software~Collexis
(\url{www.collexis.nl}) is used. Collexis uses the \emph{fingerprint}
concept and a vector-based search strategy.

The terms in the texts are preprocessed with a thesaurus and then a
vector-space is set up in which the frequency of occurrance of words
and phrases (weighted with inverse-frequency weights) are the
dimensions. The set of phrases and
terms with their weight factors is called the
\qstring{fingerprint}\index{fingerprint} of the document.  In this way
for each document in the corpus a vector can be constructed in which
every term or phrase is a dimension. If the inner-product of the
vectors of two documents is large, it is assumed that the documents
are related to each other. To find documents that are related to legal
concepts, for each of the concepts a \emph{search
  document}\index{search document} has been manually constructed by a
legal expert. The search document consists of terms and phrases that
are often used in texts about the underlying concept. When weight
factors are appended to the words and terms, the search document is
its own fingerprint. Documents in the corpus of which the
inner-product of their vector and the vector of the search document is
large, are assumed to be relevant with respect to the concept of the
search document.

@%The program in this document receives references to a set of concepts
@%that are relevant for a certain case, as well as references to a set
@%of legal verdicts for which the concepts are relevant. It is capable
@%to list and explain the concepts themselves, as well as to display the
@%verdicts, with the relevant parts highlighted. For the latter task,
@%the program uses the search documents that belong to the concepts.

\section{The m4_progname program}
\label{sec:m4_progname}


This document describes a (prototype for) a program that performs
point~6 of the list in section~\ref{sec:horseshoe} and in
figure~\ref{fig:horseshoe}. The program performs the following:
\begin{itemize}
\item It is a web \php{} application that is activated in a browser.
\item When it starts, it gets the \textsc{uri} of one or more legal
  concepts (via CGI).
\item Each of the concepts can be found in an ontology on a remote
  ontology server (cf.~section~\ref{sec:ontologyoverview}).
\item The program may find the \textsc{uri}'s of other concepts of
  which the given concepts are subclasses.
\item The program finds in the ontology an explaining text for each of
  the concepts found.
\item The program derives the \textsc{id}'s of \qstring{search
  documents}, one for each of the concepts found,
\item The program performs for each of the concepts a query in a
  data-mining program (cf.~\ref{sec:datamining-overview})
  to obtain the \qstring{search documents}.
\item The program performs for each of the concepts a query in the
  data-mining program to obtain
  the \textsc{id}'s of verdicts for which the concept is relevant.
\item The program displays the concepts with their help files, and
  illustrates them with the verdicts, in which the paragraphs that
  contain phrases from the search document occur are highlighted.
\end{itemize}

The program is in fact a \textsc{php} script that is processed by a
\textsc{http} server e.g.{} Apache on request of remote browsers.
There is a sister-program to the display program, that serves mainly
to edit help-texts.


\subsection{Modes of operation}
\label{sec:opmodes}

The current version has two modes for presentation:
\emph{Document-oriented mode} in which initially a list of relevant
verdicts is presented and \emph{Concept-oriented mode} in which
initially a list of relevant concepts is presented.

In document-oriented mode, the following happens:

\begin{itemize}
\item The computer presents a clickable list of references to relevant
  verdicts.
\item When the user clicks on one of the references, the verdict is
  displayed, as well as two clickable lists of relevant concepts:
  \emph{active} concepts (initially empty) and \emph{non-active}
  concepts. The user can select up to~m4_maxactiveconcepts concepts to become active
  (by clicking). When
  the user places the mouse on top of a concept, an explaining text
  appears in a pop-up window.
\item When a verdict is displayed, the paragraphs that are relevant
  for one or more active concepts are highlighted and strings in the
  texts that correspond to strings in the fingerprint are highlighted.
  The user can choose to have the entire verdict displayed or only the
  relevant paragraphs. To avoid confusion and overload of the user
  cognive capacity, the number of active concepts is limited.
\end{itemize}


The author of this program has the impression that the combination of
multiple concepts in a single verdict might be confusing for a
layman-user and that it might be easier for him to describe one
concept (\qstring{aspect of your problem}) at a time. This can be evaluated
in the concept-oriented mode.

\begin{itemize}
\item The computer presents a clickable list of concepts (\qstring{aspects of
  your problem}).
\item When the user places the mouse-cursor on top of a concept, an
  explanation appears in a pop-up window.
\item When the user clicks on one of the concepts, the explanation of it is
  displayed, as well as a clickable lists of relevant verdicts.
\item When the user selects a verdict, it is displayed and the
  relevant paragraphs and text-strings are highlighted.
\end{itemize}

@%It starts with a set of fingerprints and a set of legal
@%  verdicts for which the concepts associated to the fingerprints are
@%  relevant
@%\item It presents the list of documents and the list of concepts on a
@%  window in a computer screen.
@%\item When the user clicks on a concept, a window opens in which
@%  the concept is explained, as well as the reason that this concept is
@%  relevant. The document list contains only the documents that are
@%  relevant with respect to this concept.
@%\item When the user clicks on a document, the document opens, with the
@%  relevant paragraphs highlighted (e.g.\ with a contrasting
@%  colour). In the paragraph, the words in the fingerprints are
@%  highlighted with another colour. The user can select other concepts to be
@%  highlighted (with different colours) as well.
@%\item There is a summary mode, in which only the relevant paragraphs
@%  are shown. The summary mode can be extended, to display the relevant
@%  pararaphs of multiple documents in a single window.


\subsection{Invocation of the program}
\label{sec:invocation}

The program starts on a \textsc{http} request on the host of the
program. It is meant that the request is generated by another
computer-program that passes relevant concepts in the request.

When the \textsc{url}
\qstring{\url{http://cli.vu/best/display}} is received, the program
starts in a demo-mode. It loads concepts and lists of relevant verdicts
files instead of from the ontology. 

To use the program in its full capability, concept names are added to
the \textsc{url}, like e.g.{}%
 \url{http://cli.vu/best/display/index.php?concept1=Kenbaarheid&concept2=Ernst_en_duur}.


\subsection{Flow of the program}
\label{sec:progflow}

The display program is contained in \verb|m4_webdir/index.php|. 

When invoked in demo-mode it's
main flow is sketched in the diagram in figure~\ref{fig:mainflow}.
\begin{figure}[hbtp]
  \centering
  \includegraphics{mainflow.fig}
  \caption{Scheme of the flow of the main program in demo-mode.
    Initially the user chooses between concept-oriented mode
    (\texttt{c-mode}) or a document-oriented mode (\texttt{d-mode}) on
    a set of concepts and associated verdicts. In concept-oriented
    mode the user selects a concept that will be explained and
    illustrated with relevant verdicts. In document-oriented mode, the
    user chooses a verdict and have parts of it that are relevant for
    one or more concepts highlighted. The user can return to the
    initial screen with an \qstring{Opnieuw} button (dashed arrows).}
  \label{fig:mainflow}
\end{figure}

The \qstring{backdoor program} is contained in
\verb|m4_backdoordir/index.php|. The user chooses to either add/modify
a text that explains a concept or to add/modify a text that explains a
legalese word. When the user made a choice, a list of objects of whih
the helptext can be modified is presented and, in case of the
legalese, an opportunity is added to add another legalese word. There
is an \verb|Opnieuw| button to revert to the original screen. A
schematic graph is shown in figure~\ref{fig:helpeditflow}.

\begin{figure}[hbtp]
  \centering
  \includegraphics{helpeditflow.fig}
  \caption{Scheme of the flow of the \qstring{backdoor} program tot edit
    help-texts. Initially the user chooses to edit either explanations
    of concepts (c-mode) or explanation of legalese (l-mode). Thje
    next screen lists either the concepts or the legalese words for
    which help is available. The user selects one of the concepts or
    words or intends to create an explanation for a new legalese word.
    The next screen allow the user to perform the editing. When she is
    ready, the program reverts to the screen in which the user selects
    another concept or another word.  The user can return to the
    initial screen with an \qstring{Opnieuw} button (dashed arrows).}
  \label{fig:helpeditflow}
\end{figure}


\section{Resources}
\label{sec:resources}

Currently, the program in this document is still in an unfinished
\emph{demo} state. In this state we use mock-up versions of some of
the resources.

\subsection{Fingerprints}
\label{sec:fingerprintfiles}

To each of the concepts belongs a \emph{fingerprint file}. Fingerprint files are stored in the Collexis software, but since I do not yet not know how to retrieve them from there, they are also stored in directory
\verb|m4_fingerprintdir|.

@%Currently, there are~m4_nrofconcepts
@%fingerprints. The first line of the fingerprint file contains the
@%title and each of the following lines contain a weight factor, a
@%\texttt{tab} character and a word or phrase.
@%
@%The concepts are numbered. The name of a fingerprint file is the
@%concatenation of string \texttt{fp} and the number of the concept.
@%
For example, the fingerprint-file for concept~5 (\emph{causality}) is shown in
figure~\ref{fig:causalityfp}.
\begin{figure}[hbtp]
  \centering
\begin{verbatim}
causaliteit
100	schade ook zonder die gedraging zou zijn ontstaan
 95	causaal verband tussen die gedraging en de aldus ontstane schade
 87	buiten de lijn van de normale vewachtingen
 87	door zijn daad veroorzaakte schade
 87	zonder die gedraging zou zijn ontstaan
 87	niet te verwachten gevolg
 87	rekening mee heeft moeten houden
 87	ermede rekening had kunnen houden
 87	zodanig verband met de fout
 77	causaal verband tussen de schade en het onrechtmatig handelen
 77	toerekeningsverband
 77	kans verhoging
 77	vereist verband
 77	kans is verhoogd
 71	zodanig onwaarschijnlijk
 71	mogelijke gevolg
 66	aansprakelijheid
 63	omkeringsregel
 60	verwezenlijking van het risico
 60	te verwachten gevolg
 60	causale relatie
 58	causaal verband
 51	rekening heeft kunnen houden
 49	ingetreden
 46	toerekening
 46	daardoor veroorzaakte schade
 45	condicio sine qua non-verband
 41	daardoor veroorzaakt
 40	in de normale lijn van de verwachtingen
 40	aansprakelijk

\end{verbatim}
  \caption{Fingerprint file (with weight factors) of concept~5
    (Causality)}
  \label{fig:causalityfp}
\end{figure}

\subsection{Pointers to relevant verdicts}
\label{sec:verdictlists}

Until around june~2008, a set of concepts with labels \texttt{fp}\emph{n}
has been used (\emph{n} a number between~1 and~36). For these fingerprints, a legal expert (Elisabeth Uijttenbroek)
has selected a set of legal verdicts for which the concept that
belongs to the fingerprint is relevant. In appendix~\ref{sec:relverds}
the \textsc{ljn} codes of these verdicts are stored in
files. The older concepts and verdict-lists are used in the
demo-mode. Otherwise, lists of relevant legal verdicts are obtained from
Collexis.


\subsection{Case-groups}
\label{sec:clustered}

Elisabeth Uijttenbroek has created lists of verdicts for which certain
combinations of concepts (fingerprints) are relevant. Let us imagine
that the verdicts and concepts in such a cluster are relevant for a
case that a user (layman) of this program has brought up. These
clusters are listed and stored in \emph{casegroup files} in
section~\ref{sec:casegroups}. The first line in each casegroup file
lists the relevant concepts and the other lines list the \ljn's of the
verdicts that belong to the cluster. The casegroups are used when the
program starts in document-oriented demo-mode.


\section{Program languages}
\label{sec:languages}

To perform the required tasks, we will use \textsc{lamp} (Linux,
Apache, Mysql, \php{}) and Ajax (Asynchronous Javascript and \xml{}). The features of \textsc{lamp} are:

\begin{itemize}
\item Known (at least by me, the author).
\item Open source and available.
\item Platform-independent, in spite of the \emph{L} of Linux.
\item Can be instantly used everywhere where there is an Internet connection.
\end{itemize}

To add speed to the web pages, some elements will be implemented in
Ajax using \href{http://xajaxproject.org/}{xajax}.


\section{Outline of the chapters}
\label{sec:outline}

\begin{description}
\item[Chapter~\ref{chap:introduction}:] Introduction.
\item[Chapter~\ref{chap:dispback}:] Main code of the main program and the
  backdoor program. Style and layout of the web-pages.
\item[Chapter~\ref{chap:communication}:] Describes and implements how
  parameters are communicated via the \textsc{url}.
\item[Chapter~\ref{chap:annothelp}:] Describes and implement help for the user
  by way of highlighting with colours, tooltips and helptexts. 
\item[Chapter~\ref{chap:printannotated}:] The program code that annotates the
  text of a verdict and displays it on the screen.
\item[Chapter~\ref{chap:resources}:] Description and construction of
  interfaces with the external resources Sesame (the ontology
  server) and Collexis (the datamining tool to obtain relevant
  verdicts). The interface with the database of verdicts is not in
  this document, but in
  \extref{rnlmysql}{http://cli.vu/best/pdf/rnlmysql.pdf}.
\item[Chapter~\ref{chap:softstruct}:] Software structures e.g.{} for
  management of concepts and of concept sets.
\item[Chapter~\ref{chap:testprogs}:] Test programs.
\item[Appendix~\ref{chap:translatedoc}:] Appendix. Explanation about how this
  document can be used and implementation of a \texttt{Makefile} to
  extract the program code and to print the text.
\item[Appendix~\ref{chap:stylesheet}:] The cascaded style-sheet.
\item[Appendix~\ref{chap:resources}:] Lists files with \ID's of verdicts for
  which certain concepts or certain concept sets are relevant. 
\end{description}

@%This chapter contains the major part of the program code. It is
@%divided up into the following parts:
@%
@%\begin{description}
@%\item[Programs and program flow:]~\ref{sec:programs}. The framework of
@%  the php programs and the communication by way of query-strings
@%  added to the address of the web-page (section~\autoref{sec:communication}.
@%\item[Layout of the web pages:]~\ref{sec:layout}. The \textsc{html}
@%  code and the style-sheet.
@%\item[Tooltips:]~\ref{sec:tooltips}. Tooltips are windows that pop up
@%  when the user points to some place with the mouse. We provide help
@%  using tooltips.
@%\item[Provide help:] Help texts are available for concepts and for
@%  legalese words. Present these text on windows (\emph{tooltips}) that
@%  pop up when the user moves his mouse on top of a word or concept title.
@%\item[Selection of concepts:]~\ref{sec:concepts-selection}. In
@%  document-oriented mode, the user may select a set of \qstring{active}
@%  concepts to be illustrated in a verdict. The Conceptset class reads
@%  the set from the querystring and makes it available.
@%\item[Read a fingerprint file:]~\ref{sec:readfingerprint}. Read the title of a concept or read
@%  the phrases in a fingerprint file.
@%\item[properties of strings that match fingerprint phrases]~\ref{sec:matchstrings}.  
@%  The class Matchingstring stores these properties.
@%\item[Print the annotated verdict:]~\ref{sec:printannotated}. Create a
@%  function that returns a string with the annotated verdict in it, ready to
@%  be displayed in a window on the screen. The string can contain the
@%  full verdict, or only parts that are relevant w.r.t.{} the set of
@%  active concepts. Tooltips with helptexts for the legalese words are
@%  contained in the string.
@%\item[The windows to be displayed:]~\ref{sec:windows}. Create the
@%  windows in which the program does what it has to do. 
@%\end{description}


\chapter{Display and backdoor program}
\label{chap:dispback}

In this chapter the \php{} code to generate the web pages for the display
program and the associated backdoor program is constructed. Both
programs consist of a single \php{} script named \texttt{index.php}
and located at a place where the web-server can find them. The
programs are controlled with \textsc{cgi} instructions in the header
(cf.{} section~\ref{chap:communication}.).

\section{The PHP scripts}
\label{sec:indexpages}

The main program sets up a regular \textsc{html} page with a header
and a body. Most of the actual work is done in a \php{} function
\texttt{content()} that is called in the body part of the \HTML{}
script. At the end of the script, \php{} functions are included:

@o m4_webdir`'/index.php  @{@%
<?php
  @< initial php statements @>
  \$paginatitel="m4_webpagtitle";
?>
<!DOCTYPE html 
     PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="nl" lang="nl">
  <head>
    <?php
      @< php statements in the header of index @>
    ?>
    @< the html statements in the header @>
  </head>
  <body>
    @< the html statements in the body @>
    <?php
      @< init javascript @>
    ?>
  </body>
</html>
<?php
  function content(){
    @<content van index @>
  };
  @< functions of index @>
 @< php functions @>
?>
@| @}


The \qstring{backdoor} main page:

@o m4_backdoordir/index.php @{@%
<?php
  @< initial php statements @>
  \$paginatitel="m4_webbackdoortitle";
?>
<!DOCTYPE html 
     PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="nl" lang="nl">
  <head>
    <?php
        @< php statements in the header of backdoordir/index @>
    ?>
    @< the html statements in the header @>
  </head>
  <body>
    @< the html statements in the body @>
    <?php
      @< init javascript @>
    ?>
  </body>
</html>
<?php
  function content(){
    @<content of backdoordir/index @>
  };
  @< functions of backdoordir/index @>
 @< php functions @>
?>
@| @}


Do not forget to create the directories in which the programs reside:


@d create directories @{@%
  mkdir -p m4_webdir
  mkdir -p m4_backdoordir
@| @}



@d php statements in the header of backdoordir/index @{@%
@< initialize tinymce @>
@%@< xajax statements in the header @>
@%@< Javascripts in the header @>
@| @}

\section{Layout and html code}
\label{sec:layout}

The layout has been stolen from Michel Klein's%
\index{Michel Klein|see{Klein, Michel}}\index{Klein, Michel}Michel
 page about the \best{} project
(\href{www.best-project.nl}{www.best-project.nl}).

\subsection{Character encoding}
\label{sec:characterencoding}


Set locale to \verb|m4_locale|:

@d initial php statements @{@%
\$currloc=setlocale(LC_ALL,'m4_locale');
@%printf("\n<!--- locale: %s --->\n", \$currloc);
@| setlocale LC_ALL @}


\subsection{Style-sheet}
\label{sec:stylesheet}

Most of the style-sheet has also been stolen from
\href{www.best-project.nl}{www.best-project.nl}. 

Create the style-sheet, \verb|m4_stylesheetname| in it's own
directory \verb|m4_stylesheetdir|:

m4_nieuwedir(m4_stylesheetdir)m4_dnl

@o m4_stylesheet @{@%
@< style sheet elements @>
@| @}

The majority of the style-sheet elements have been listed in the
appendix (\ref{chap:stylesheet}.


@%\subsection{Page title}
@%\label{sec:pagetitle}
@%
@%Some of the pages get a fixed title, but in other cases the title
@%must be obtained from the database. 
@%
@%We arrange that in such a case the string \verb|infile| is passed as
@%the argument in scrap \verb|standaardinhoud|. Find out whether this is
@%the argument that has been passed. If that is the case, do some
@%complicated things that we will discuss later.
@%
@%@d print the title @{@%
@%  <?php
@%     \$infile="infile";
@%     if(\$infile==@1){
@%       @< get the title from a file @>
@%     } else {
@%       printf("%s\n", @1);            
@%     };
@%  ?>
@%@| @}



\subsection{The header part}
\label{sec:head}


The header specifies to use the Unicode%
\index{unicode}\index{character-set},
because the majority of the verdicts have been encoded with it. However, Unicode
still causes many problems, so it might be that we want to change this
eventually.

For the rest, the header part is rather straightforward, with a
specification of the style-sheet.


@d the html statements in the header @{@%
@%<meta content="text/html; charset=iso-8859-1" http-equiv="Content-Type" />
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta content="m4_author" name="Author"/>
<title>
@% @< print the title @( \$paginatitel @) @>
  <?php printf("%s\n", \$paginatitel); ?>
</title>
<link rel="stylesheet" type="text/css" href="m4_stylesheeturl"/>
@| @}

@%\subsubsection{Blurb}
@%\label{sec:blurb}
@%
@%
@%A few \qstring{blurb} definitions.  Some of them get default values if they
@%have not obtained a value in another way.
@%
@%@d initial php statements @{@%
@%  \$authors="m4_author";
@%  
@%  if(!isset(\$keywords)){
@%     \$keywords="rechtsbijstand, juridisch advies BATNA";
@%  };
@%
@%  \$institute_description="BEST";
@%
@%  if(!isset(\$description)){
@%    \$description=\$institute_description;
@%  };
@%
@%  if(!isset(\$pagename)){
@%    \$pagename="Wat is mijn positie??";
@%  };
@%
@%@| @}


\subsection{The layout in the body}
\label{sec:body}

The page consists of a head, a bar with knobs, a \qstring{content}
part and a footer.

@d the html statements in the body  @{@%
@< banner heading @>
@< knobs bar @>
@< content part @>
@< page footer @>
@| @}

\subsubsection{Header with banner and logo}
\label{sec:banner}

@d banner heading @{@%
<!-- **** top of the page **** -->
<table width="100%">
 <tr>
   <td>
    <div class="bannerheading">m4_bannerheading
    </div>
    <div class="bannersubheading">
      m4_bannersubheading
    </div>
   </td>
   <td>
     <img src="m4_bestlogo" width="m4_bestlogowidth" 
                           hspace="10"  align="right"
        alt="BEST logo"/>
   </td>
 </tr>
</table>
@| @}


\subsubsection{Navigation bar}
\label{sec:navbar}

Add a navigation bar%
\index{navigation bar}.
Currently the bar has three knobs:
\begin{description}
\item[Opnieuw:]\index{opnieuw} Start again. Display the initial page.
\item[Help:] Provide context-sensitive help in a \emph{tooltip} (see
  section~\autoref{sec:help}).
\item[Best:] Points to the web-site of the \best{}-project.
\end{description}
@d knobs bar @{@%
<!-- **** Navigation Bar **** -->
<div id="navigation">
 <a class=ord href="<?php printf("%s", m4_ikzelf); ?>" 
    title="Begin opnieuw">Opnieuw</a> | 
 <?php helpbutton() ?> |
 <a class=ord href="http://www.best-project.nl" 
    title="BEST-project Home">Best</a> | 
</div>
@| @}

The \qstring{helpbutton} is not a real button but a place where a tooltip
(section~\autoref{sec:tooltips}) appears when the mouse has been placed
there.

\subsubsection{Content part}
\label{sec:contentpart}


The content of a page is contained in a \php{} function \verb|content()|.

@d content part @{@%
<div id="content">
  <?php content();?>
</div>
@| @}

@%Probably, we often want three panels in the content part, a wide main
@%panel with narrow secondary panels left and right to it.
@%To do this,
@%include the following scrap into the scrap for the content of that
@%page, and define the three \php{} functions \verb|leftpanelcontent()|,
@%\verb|centerpanelcontent()| and \verb|rightpanelcontent()|.
@%
@%m4`'_dnl m4_define(m4_leftpanelwidth, `200px')m4_dnl
@%m4`'_dnl m4_define(m4_rightpanelwidth, `100px')m4_dnl
@%Currently, the width of
@%the side-panels is \verb|m4_leftpanelwidth|.

@%
@%@d three-panel content @{@%
@% ?>
@% <table width="100%">
@%   <tr>
@%    <td width="m4_leftpanelwidth"  valign="top">
@%     <?php leftpanelcontent();?>
@%    </td> 
@%    <td  valign="top">
@%     <?php centerpanelcontent();?>
@%    </td> 
@%    <td width="m4_rightpanelwidth"  valign="top">
@%     <?php rightpanelcontent();?>
@%    </td> 
@%   </tr>   
@% </table>
@% <?php
@%@| @}

@%As can be seen in figure~\ref{fig:mainflow}, we will most of the time present the real
@%content in a two-panel layout. A relatively narrow left panel contains
@%lists of concepts of \ljn{} codes and the wide right panel contains
@%explanations or displays the content of verdicts.

m4_dnl m4_define(m4_leftpanelwidth, `200px')m4_dnl

@%@d conceptoriented content @{@%
@% ?>
@% <table width="100%">
@%   <tr>
@%    <td width="m4_leftpanelwidth"  valign="top">
@%     <?php leftpanelcontent();?>
@%    </td> 
@%    <td  valign="top">
@%     <?php centerpanelcontent();?>
@%    </td> 
@%@%    <td width="m4_rightpanelwidth"  valign="top">
@%@%     <?php rightpanelcontent();?>
@%@%    </td> 
@%   </tr>   
@% </table>
@% <?php
@%@| @}

\subsubsection{The page footer}
\label{sec:paginavoet}

@d page footer @{@%
<div id="footer">
  @< time stamp @>
  @< w3c validation button @>
</div>
@| @}

The M4 pre-processor places a time-stamp.

@d time stamp @{@%
m4_changequote(`?',`!')m4_dnl
  Versie van m4_esyscmd(?date +'%d-%m-%Y, %H%M'| tr -d '\012'!)
m4_changequote(`,')m4_dnl
@| @}

A w3c button serves to check whether the html/xml code in this page is
valid.

@d w3c validation button @{@%
<a class=ord href="http://validator.w3.org/check/referer">
<img class="cert"
     src="m4_grapURL/valid-xhtml10.gif"
     alt="Valid XHTML 1.0?"/>
</a> 
@| @}


\section{Paint the content windows}
\label{sec:contentwindows}

Design the windows that have been represented as ellipses in
figures~\ref{fig:mainflow} and~\ref{fig:helpeditflow}. For each window
we construct a function that does the work.
Chapter~\ref{chap:communication} describes how these functions are
called (in \autoref{contentvanindex}). The following functions will
be made for the display program:

\begin{description}
\item[display\_nomode:] Enable the user to choose a mode in the main
  display program (\autoref{displaynomodefunction}).
\item[display\_conceptorientedmode:] Manage concept-oriented mode in
  the main display program (\autoref{displayconceptorientedmode}).
\item[display\_documentorientedmode:] Manage document-oriented mode in
  the main display program (\autoref{displaydocumentorientedmodefunction}).
@%\item[edit\_nomode:] Allow to select what helptexts to edit.
@%\item[edit\_concept\_mode:] Allow to edit help-texts for concepts. (\autoref{backdoorcontent}).
@%\item[edit\_legalese\_mode:] Allow to edit help-texts for legal words. (\autoref{backdoorcontent}).
\end{description}

The following functions will
be made for the backdoor program:
\begin{description}
@%\item[display\_nomode:] Enable the user to choose a mode in the main
@%  display program (\autoref{displaynomodefunction}).
@%\item[display\_conceptorientedmode:] Manage concept-oriented mode in
@%  the main display program (\autoref{displayconceptorientedmode}).
@%\item[display\_documentorientedmode:] Manage document-oriented mode in
@%  the main display program (\autoref{displaydocumentorientedmodefunction}).
\item[edit\_nomode:] Allow to select what helptexts to edit
  (\autoref{editnomodefunction}).
\item[edit\_concept\_mode:] Allow to edit help-texts for concepts. (\autoref{editconceptmodefunction}).
\item[edit\_legalese\_mode:] Allow to edit help-texts for legal words. (\autoref{editlegalesemodefunction}).
\end{description}


\subsection{Ask the user to select a usermode}
\label{sec:mode}

Initially, ask the user in which mode she wants to use this
program. Make a header and display for each mode some explanation and
buttons to select it. 

\label{displaynomodefunction}%
@d functions of index @{@%
function display_nomode(){
  printf("<h1>Kies een presentatievorm</h1>");
  @< display concept-oriented option @>
  @< display case-oriented option @>
}
@| @}

\subsection{Display concept-oriented mode}
\label{sec:displayconceptoriented}

\subsubsection{The information and the choice}
\label{sec:infochoice}

The help-text and the button to select concept-oriented mode in the
initial window:

@d display concept-oriented option @{@%
?>
<h2>Concept-georienteerde modus</h2>
<p> In deze modus selecteert u een concept uit een lijst in het
linkerpaneel. U krijgt dan uitleg over deze modus en u krijgt een lijst van
uitspraken waarin dit concept relevant is. U kunt een bestand in
zijn geheel laten
presenteren op het scherm of alleen de passages waarin het concept
aan de orde komt.
@| @}

The button is an \verb|<a>| tag.

@d display concept-oriented option @{@%
</p>
   <a class=ord href="<?php
       printf("%s", address_with_modified_querystring("m4_modekeyword", "c"));
       ?>"
   >
        Ik wil de concept-georienteerde modus.
   </a>
<?php
@| @}


\subsubsection{Set-up of the window}
\label{sec:co-setup}

In concept-oriented mode, the home page displays two panels. The left
panel contains a list of concepts. The user may select one of the
concepts. The right panel displays an explanation of the selected
concepts and the \ID{}'s of relevant verdicts. The user may select one
of the verdicts to have its text displayed in the right window.

\label{displayconceptorientedmode}%
@d functions of index @{@%
function display_conceptorientedmode(){
  ?>
  <table width="100%">
    <tr>
      <td width="m4_leftpanelwidth"  valign="top">
       <?php concepto_leftpanelcontent();?>
      </td> 
      <td  valign="top">
       <?php concepto_rightpanelcontent();?>
      </td> 
    </tr>   
  </table>
  <?php
}
@| display_conceptorientedmode @}

\subsubsection{The left panel}
\label{sec:leftpanel}

The left panel lists the relevant concepts. Currently, make a list of
the old-fashioned concepts.

@d functions of index @{@%
function concepto_leftpanelcontent(){
  global \$conceptset;
  @< variables of concepto\_leftpanelcontent @>
@%    \$conceptset->store_old_concepts();
  @< present the relevant concepts @>
@%   @< maak lijst met uitspraken die de woorden bevatten @>
}

@| concepto_leftpanelcontent @}


Explain the user what information she is going to get. Mention that
there are relevant concepts and list them.

The concepts that will be used in this session are stored in an object
of the \verb|Conceptset| class (cf.~\autoref{sec:whichconcepts}).

@d present the relevant concepts @{@%
printf(" <h2>Aspecten van uw probleem</h2>\n");
if(count(\$conceptset->conceptcount())<=0){
  printf("<p>Uw probleem heeft geen interessante aspecten.\n");
  printf("Als u het zelf niet kunt oplossen kunt u het beste\n");
  printf("een advocaat bellen.</p>\n");
}else{
  printf("<p>Uw probleem heeft de volgende aspecten.\n");
  printf("Klik op een aspect om er meer informatie over\n");
  printf("te krijgen:</p>\n");
  @< print a list with concept-titles @>
};
@| @}


@%At this moment we display
@%all the concepts for which we have relevant verdicts
@%(section~\ref{sec:verdictlists}). For each of these concepts there
@%exist a corresponding file that lists the verdicts. The following
@%macro creates an array \verb|\$relevantconcepts| with the numbers of
@%the concepts for which such files exist.
@%
@%\textbf{Note:} that the first keys of array \verb|\$relevantconcepts|
@%is unity and not zero.
@%
@%@d make a list of relevant concepts @{@%
@%unset(\$relevantconcepts);
@%\$nrofrelevantconcepts=0;
@%for(\$i=1;\$i<=m4_nrofconcepts;\$i++){
@%  \$verdictslistfilename="m4_verdictslist.fp".\$i;
@%  if(file_exists(\$verdictslistfilename)){
@%   \$nrofrelevantconcepts++;
@%   \$relevantconcepts[\$nrofrelevantconcepts]=\$i;
@%  };
@%};
@%@|\$relevantconcepts  \$nrofrelevantconcepts \$verdictslistfilename @}

@%At this moment we display
@%all the \qstring{fp}-style concepts.
@%
@%\textbf{Note:} that the first keys of array \verb|\$relevantconcepts|
@%is unity and not zero.
@%
@%@d make a list of relevant concepts @{@%
@%\$conceptset->store_old_concepts();
@%@| @}

@%Extract the concepts from the array and print them with tooltips that
@%provide explanations .  Initialise an
@%object with help-texts for tooltips. (function
@%\verb|old_pointer_to_single_concept|, from
@%section~\ref{pointertosingleconcept}) provides an \verb|<a>| tag, with
@%a tooltip, that causes the concept to be selected).

Print the titles of the concepts with help-texts in tooltips.

@d print a list with concept-titles @{@%
@%\$concepthelptexts= new Concepthelptext();
printf("<ul>\n");
for(\$i=1;\$i<=\$conceptset->conceptcount();\$i++){
@%  printf("<li>%s\n",  old_pointer_to_single_concept(\$relevantconcepts[\$i], \$concepthelptexts));
  printf("<li>%s\n",  pointer_to_single_concept(\$i));

};
printf("</ul>\n");
@| @}

If the user clicks on a concept, the concept is made \emph{active}%
\index{active concept}\index{concept, active}.
Active concepts will be listed on the right panel and the user may
have their texts annotated and displayed. In \emph{concept mode} at most
a single concept can be active.

To activate the selected concept, generate a \verb|<a>| tag that has
this page as target and that includes the selected concept as the
single active concept in the query-string.


@d functions of index @{@%
function pointer_to_single_concept(\$conceptnum){
  global \$conceptset;
  \$conc=\$conceptset->concept(\$conceptnum);
  \$questr=\$conceptset->querystring_with_conceptnr(\$conceptnum, "c");
  \$questr=remove_filename_from_querystring(\$questr);
  \$returnstring
      = reference_with_tooltips(
           \$conc->title(),
           \$conc->explanation(),
           "m4_webURL`'/index.php?".\$questr
        );
  return \$returnstring;
};

@| pointer_to_single_concept @}


\subsubsection{The right panel}
\label{sec:co-rightpanel}

When the user has selected a concept, the right panel contains an
explanation about it and pointers to verdicts for which the
concept is relevant. The user may select one of the verdicts to be
annotated and displayed.

The following function determines whether the user selected a concept
and-or a verdict and fills the right window:
 
\begin{itemize}
\item If the user has not yet chosen a concept, print only a message to
  urge her to make a choise. Otherwise, proceed.
\item Print an explanation about the concept.
\item Print a list of \ljn's of verdicts for which the concept is
  relevant. The user may select one of the verdicts.
\item If the user has indeed selected a verdict, proceed and display
  the verdict.
\end{itemize}

Information about a concept is stored in an object of the
\texttt{Concepto} class (cf.~\autoref{sec:concept}) that is stored in
the \verb|Conceptset| object. Make variable \verb|\$conc| point to the
object of the concept to be displayed.

@d functions of index @{@%
function concepto_rightpanelcontent(){
  global \$conceptset;
  if(\$conceptset->active_concept_count==0){
    printf("<p>Klik op een aspect in het linker venster</p>\n");
    return;
  };
  \$conc=\$conceptset->active_concept(0);
@%  \$ca=\$conceptset->arra();
@%  \$conceptnum=\$ca[0];
  @< print the info on the concept @>
  printf("<hr>\n");
  @< print list of files for the concept @(\$conceptnum@) @>
  printf("<hr>\n");
  \$filnam=parameter_value_of('m4_filenamekeyword');
  if(\$filnam==""){
    printf("<p>Klik op een bestandsnaam om hem in dit venster te zien.</p>\n");
  } else {
    @< display the selected verdict @>
  };
};
@| concepto_rightpanelcontent @}


Print the concept title and an explaining text.

@d print the info on the concept @{@%
@% printf("<h2>%s</h2>\n", @1->title());
@%\$concepthelp=new Concepthelptext();
printf("<h2>%s</h2>\n", \$conc->title());
printf("%s\n", \$conc->explanation());
@%\$fingerprintfile="m4_fingerprinttextdir/fp".@1;
@%if(file_exists(\$fingerprintfile)){
@%  printf("%s\n",file_get_contents(\$fingerprintfile));
@%} else {
@%  printf("<p>Er is geen helptekst voor dit concept.</p>\n");
@%};
@|  @}


@%@d print list of files for the concept @{@%
@%\$ljnlist="m4_verdictslist.fp".@1;
@%if (\$handle = fopen(\$ljnlist, "rb")) {
@%  \$i=0;
@%  while(!feof(\$handle)){
@%    #note: strip linefeed with rtrim.
@%    \$file = rtrim(fgets(\$handle));
@%    \$questr=modified_querystring('m4_filenamekeyword',\$file);
@%    printf("<a class=ord href=\"m4_webURL`'/index.php?%s\">%s</a> ", \$questr, \$file);
@%   \$i++;
@%  };
@%  fclose(\$handle);
@%};
@%@| \$ljnlist @}


@d print list of files for the concept @{@%
if(count(\$conc->verdicts())<=0){
  printf("Er zijn geen relevante uitspraken bekend.\n");
} else {
  foreach(\$conc->verdicts() as \$key => \$verdid){
    \$questr=modified_querystring('m4_filenamekeyword',trim(\$verdid));
@%    @< pemess @("<p>questr:".\$questr."</p>"@) @>
    printf("<a class=ord href=\"m4_webURL`'/index.php?%s\">%s</a> ",\$questr, \$verdid); 
  };
};
@| @}


Ajax (see \autoref{sec:wrapinajax}) will be used to print the
verdict. Print a button with which the user chooses to display the full
text of the verdict or only the relevant parts. Print a tag that
serves as \qstring{placeholder} in which the ajax function writes the verdict.

@d display the selected verdict @{@%
printf("<p align=\"center\">\n");
 @< button to select entire doc or relevant parts only @>
printf("</p>\n");
 printf("<h2>Uitspraak %s</h2>\n", \$filnam);
@< placeholder for the annotated verdict @>
@| @}


\subsection{Display document-oriented mode}
\label{sec:displaydocoriented}

\subsubsection{The information and the choice}
\label{sec:infochoice}


Document-oriented mode is in fact case-oriented. In the original mode,
we displayed groups of verdicts that were relevant for a given set of
concepts. When concept parameters are displayed, we use these concepts
and display the verdicts that are relevant for them.

Is concepts have been passed with \verb|conceptn| parameters, we use
them. Otherwise we use a demo.

@d display case-oriented option @{@%
if(parameter_value_of('concept1')==""){
  @< display information about the demo case-oriented option @>
  @< display a table with pointers to case-sets @>
} else {
  @< display information about the document-oriented option @>
  @< display a button to the document-oriented option @>
};
@| @}

@d display information about the demo case-oriented option @{@%
?>
<h2>Document-georienteerde modus</h2>
<p> In deze modus selecteert u de tekst van een rechterlijke uitspraak uit een lijst in het
linkerpaneel. Deze uitspraken zijn gerelateerd aan een
(hypothetische) casus en de concepten van die casus zijn ook
relevant in deze uitspraken. 

Als u een van deze uitspraken aanklikt, dan wordt deze afgedrukt, samen
met een lijst relevante concepten. Als u concepten aanklikt, dan lichten
de passages in het document die over dat concept gaan op.

U kunt kiezen uit verschillende groepen van documenten met bijbehorende concepten:
</p>
<?php
@| @}

@d display information about the document-oriented option @{@%
?>
<h2>Document-georienteerde modus</h2>
<p> In deze modus selecteert u de tekst van een rechterlijke uitspraak uit een lijst in het
linkerpaneel. Deze uitspraken zijn gerelateerd aan een
 casus en de concepten van die casus zijn ook
relevant in deze uitspraken. 
</p>
<?php
@| @}

@d display a button to the document-oriented option @{@%
printf( "<p><a class=ord href=\"%s\">%s</a></p>\n"
      , address_with_modified_querystring("m4_modekeyword", "d")
      , "Ik wil de document-georienteerde modus"
      );
@| @}

Create a table with three columns. Each element contains of a
clickable name of a case-set and the numbers of the relevant
concepts. Function \verb|create_cases_table| generated the content of
the table.

@d display a table with pointers to case-sets @{@%
?>
<div align="LEFT">
<table CELLPADDING=3 BORDER="1">
 <tr>
   <th> Casus (concept nrs):</th>
   <th> Casus (concept nrs):</th>
   <th> Casus (concept nrs):</th> 
 </tr>
 <?php
    create_cases_table();
 ?>
</table>
</div>
<?php
@| @}


Create the table elements for the previous table: The casegroups are
stored as files in directory \url{m4_casegrouplist} (as described in
section~\ref{sec:casegroups}). Search for files in this directory
of which the names begin with \verb|FP| and do
not end with a~\verb|~| (which is an artifact of the editor). If such
a file has been found, read the first line of it (contains the numbers
of the relevant fingerprints). Make an entry for the above six-column
table.

@d functions of index @{@%
function create_cases_table(){
  \$filenamepattern="/^FP.*[^~]\$/";
  \$colnum=1;
  \$dir=opendir("m4_casegrouplist");
    while((\$file = readdir(\$dir)) !== false){
      if(preg_match(\$filenamepattern, \$file)>0){
        \$filepath="m4_casegrouplist/".\$file;
        if(\$colnum==1) printf("<tr>\n");
        @< generate a querystring for a cluster in document-mode  @>
        @< generate a list with concept IDs for this cluster @>
@%        \$questr=modified_querystring("m4_modekeyword", "d")
        printf("  <td><a class=ord href=\"index.php?%s\">%s</a> (%s)</td>\n",
                \$questr,\$file, \$conceptnrs
              );
        if(\$colnum==3){
            printf("<tr>\n");
            \$colnum=1;
        } else {
          \$colnum++;
        };
      };
    }
  closedir(\$dir);
}
@| @}


Create a query-string to be appended to the reference address in the
\verb|<a>| tag. The querystring
contains a \emph{m4_modekeyword} key with content \verb|d| and
\emph{m4_clusterkeyword} key that contains the name of the case-set.

@d generate a querystring for a cluster in document-mode @{@%
\$questarr=array("m4_modekeyword" => "d", "m4_clusterkeyword" => \$file);
\$questr=http_build_query(\$questarr);
@| \$questarr @}


Read the numbers of the relevant concepts, i.e.{} copy the first line
of the casegroup file into variable \verb|\$conceptnrs|.
 
@d generate a list with concept IDs for this cluster @{@%
\$handle=fopen(\$filepath, "rb");
\$conceptnrs=fgets(\$handle);
fclose(\$handle);
@| @}

\subsubsection{Set-up of the window}
\label{sec:doc-setup}

In case-oriented mode, the home page displays two panels. The
left panel contains a list of \textsc{ljn} codes of verdicts, related to a combination of
concepts. When the user clicks on one of the \ljn codes, the verdict
is displayed and the left panel shows the concepts that are relevant
for the hypothetical case. 

\label{displaydocumentorientedmodefunction}%
@d functions of index @{@%
function display_documentorientedmode(){
  ?>
  <table width="100%">
    <tr>
      <td width="m4_leftpanelwidth"  valign="top">
       <?php documento_leftpanelcontent();?>
      </td> 
      <td  valign="top">
       <?php documento_rightpanelcontent();?>
      </td> 
@%      <td width="m4_rightpanelwidth"  valign="top">
@%       <?php rightpanelcontent();?>
@%      </td> 
    </tr>   
  </table>
  <?php
}
@| display_documentorientedmode @}


\subsubsection{The left panel}
\label{sec:documento_leftpanel}

If the user has not yet selected a verdict to be displayed, display
only the list of (clickable) verdicts. Otherwise, display the concepts that are
relevant for the user's problem as well as for the selected verdict on top.

@d functions of index @{@%
function documento_leftpanelcontent(){
  global \$conceptset;
  \$ljn=parameter_value_of('m4_filenamekeyword');
  if(\$ljn!=""){
    @< print header for concepts list in document-mode @>
    @< print list of concepts in documento-mode @>
  };
  @< print a header for the list of related cases @>
  @< display list of verdicts in documento mode @>
}

@| display_documentorientedmode @}


Display the concepts: Display the active concepts first and then the
remaining concepts. Count the concepts in \verb|\$conceptcount|.


@d print list of concepts in documento-mode @{@%
\$conceptcount=0;
if(\$conceptset->active_concept_count()>0){
  @< print header for selected concepts list in document-mode @>
  @< print the active concepts in document mode @>
};
@%if(!(\$conceptset->first_nonactive_concept()===FALSE){
if(nonactive_concepts_remaining(\$ljn)){
  @< print header for non-active concept list in document-mode @>
  @< print the non-active concepts in document-mode @>
};
@| @}


Check whether there are concepts that are non-active and relevant for
the selected verdict.


Print a table with in each row a clickable document.

@d print the active concepts in document mode @{@%
printf("<table>\n");
\$conc=\$conceptset->first_active_concept();
while(!\$conc===FALSE){
  \$conceptcount++;
  @< print de-selectable active concept @>
  \$conc=\$conceptset->next_active_concept();
};
if(\$conceptcount>1){
  @< print combination colours @(\$conceptcount@) @>
};
printf("</table>\n");
@| @}


Display non-active concepts if there are any.


@d functions of index @{@%
function nonactive_concepts_remaining(\$ljn){
  global \$conceptset;
  \$conc=\$conceptset->first_nonactive_concept();
  if(\$conc===FALSE) return FALSE;
  while(TRUE){
    if(\$conc->is_relevant_verdict(\$ljn)) return TRUE;
    \$conc=\$conceptset->next_nonactive_concept();
    if(\$conc===FALSE) return FALSE;
  };
}
  
@| nonactive_concepts_remaining @}


@d print the non-active concepts in document-mode @{@%
printf("<table>\n");
\$conc=\$conceptset->first_nonactive_concept();
while(!(\$conc===FALSE)){
  if(\$conc->is_relevant_verdict(\$ljn)){
    \$conceptcount++;
    @< print selectable non-active concept @>
  };
  \$conc=\$conceptset->next_nonactive_concept();
}
printf("</table>\n");
@| @}


Print each concept as a table row, with three columns: 1) the concept
number; 2 a button to select or deselect the concept and 3) the title
of the concept with a tooltip. The following macro does this. It needs
two arguments:
\begin{enumerate}
\item A string that contains either \qstring{\texttt{active}} or
  \qstring{\texttt{non\_active}}.
\item A string that contains either \qstring{\texttt{aan}} or
  \qstring{\texttt{uit}}.
\end{enumerate}

@d print concept in document mode @{@%
printf("<tr>\n");
printf("  <td>%d</td>\n", \$conceptcount);
printf("  <td>%s</td>\n", @2zetknop(@3));
printf("  <td>%s</td>\n", @1_conceptlabel(\$conc,\$conceptcount));
printf("</tr>\n");
@| @}


@d print de-selectable active concept @{@%
@< print concept in document mode @(active@,uit@,\$conceptset->current_active_conceptkey() @) @>
@| @}

@d print selectable non-active concept @{@%
@< print concept in document mode @(non_active@,aan@,\$conceptset->current_conceptkey()@) @>
@| @}


@d functions of index @{@%
function aanzetknop(){
 global \$conceptset;
 \$conceptkey=\$conceptset->current_conceptkey();
 \$questr=\$conceptset->querystring_with_conceptnr(\$conceptkey, "d");
 return "<a class=ord href=\"m4_webURL`'/index.php?".\$questr."\">Sel.</a>"; 
}
@| aanzetknop @}

@d functions of index @{@%
function uitzetknop(\$connum){
 global \$conceptset;
@% \$conceptkey=\$conceptset->current_conceptkey();
 \$questr=\$conceptset->querystring_without_conceptnr(\$connum);
 return "<a class=ord href=\"m4_webURL`'/index.php?".\$questr."\">Unsel.</a>"; 
}
@| uitzetknop @}



Print the title of a non-active concept with a tooltip.

@d functions of index @{@%
function non_active_conceptlabel(\$conc, \$actnum){
  global \$conceptset;
  return tooltippeds(\$conc->title(), \$conc->explanation());

}

@| non_active_conceptlabel @}

Print the title of an active concept in the highlighting style that used for
the annotation.

@d functions of index @{@%
function active_conceptlabel(\$conc, \$actnum){
  \$frasn="f".telwoordvan(\$actnum);
  return "<span class=\"".\$frasn."\">"
         .tooltippeds(\$conc->title(), \$conc->explanation())
         ."</span>\n";

}

@|  active_conceptlabel @}


@d print lists of relevant active concepts @{@%
\$conc=\$conceptset->first_active_concept();
while(!(\$conc===FALSE)){
  if(\$conc->is_relevant_verdict(\$ljn)){
    \$conceptcounter++;
    if(\$mainconceptheadermade==FALSE){
      @< print header for concepts list in document-mode @>
      \$mainconceptheadermade=TRUE;
    };
    if(\$selectedconceptheadermade==FALSE){
      @< print header for selected concepts list in document-mode @>
      \$selectedconceptheadermade=TRUE;
    };
    \$questr=\$conceptset->querystring_without_conceptnr(\$this->current_conceptkey());
    \$seqn="p".telwoordvan(\$conceptset->concept_seqnum(\$conceptnum));
    \$frasn="f".telwoordvan(\$conceptset->concept_seqnum(\$conceptnum));
    printf("<tr>\n");
    printf("  <td>%d</td>\n", \$conceptcounter);
    printf("  <td><a class=ord href=\"m4_webURL`'/index.php?%s\">Uit</a></td>\n",\$questr);
    printf( "  <td><span class=\"%s\"><span class=\"%s\">%s</span></span></td>\n"
          , \$seqn
          , \$frasn
          , \$concepthelp->tooltipstring(\$this->current_conceptkey())
          );
    printf("</tr>\n");
  };
  \$conc=\$conceptset->next_active_concept();
};
@| @}



@d print a list of relevant concepts for this case @{@%
\$concepthelp=new Concepthelptext();
\$conceptset->first_concept();
@| @}




@%@d functions of index @{@%
@%  if(\$conceptset->conceptcount())>0{
@%
@%  if(\$conceptset->mode=="classic"){
@%@%    @< pemess @("<p>Classic mode</p>"@) @>
@%    \$clusterlist=parameter_value_of('m4_clusterkeyword');
@%    @< load the concepts from the clusterlist @>
@%    if(parameter_value_of('m4_filenamekeyword')!=""){
@%      @< print a list of relevant concepts for this case @>
@%    };
@%  } else {
@%    if(\$conceptset->mode=="sesame"){
@%@%      @< pemess @("<p>Sesame mode</p>"@) @>
@%@%      \$clusterlist=parameter_value_of('m4_clusterkeyword');
@%      if(parameter_value_of('m4_filenamekeyword')!=""){
@%        @< print a list of relevant concepts for this case @>
@%      };
@%    } else {
@%      @< pemess @("<p>Empty mode</p>"@) @>
@%    };
@%  };
@%  @< print a list of ljn numbers for this case @>
@%@% ?>
@%@% <p>
@%@% Document-geörienteerde modus is nog niet geïmplementeerd.
@%@% </p>
@%@% <?php
@%}
@%@| @}
@%


If a \qstring{clusterfile} parameter is present in the \textsc{url} of
the page, print the filenames that it contains. Otherwise, print the
verdicts that are relevant for the concepts.

@d display list of verdicts in documento mode @{@%
\$clusterlist=parameter_value_of('m4_clusterkeyword');
if(\$clusterlist==""){
@%  @< pemess @("<p>Get verdicts from the concepts</p>"@) @>
  @< display the verdicts that belong to the concepts @>
} else {
@%  @< pemess @("<p>Get verdicts from ".\$clusterlist.".</p>"@) @>
  @< display the verdicts in the clusterlist @>
};
@| @}




@d display the verdicts that belong to the concepts @{@%
@< put the verdicts in an array @>
@%@< put the verdicts and-wise in an array @>
@< display the verdicts from the array @>
@%\$conc=\$conceptset->first_concept();
@%printf("<ul>\n");
@%while(!(\$conc===FALSE)){
@%  foreach(\$conc->verdicts() as \$key => \$verdict){
@%    printf("<li>");
@%    @< print verdict as selectable item @>
@%    printf("</li>\n");
@%  };
@%  \$conc=\$conceptset->next_concept();
@%};
@%printf("</ul>\n");
@| @}


@d put the verdicts in an array  @{@%
\$conc=\$conceptset->first_concept();
\$verdar=array();
while(!(\$conc===FALSE)){
  if(count(\$conc->verdicts())>0){
    foreach(\$conc->verdicts() as \$key => \$verdict){
      if(!in_array(\$verdict, \$verdar)){
        \$verdar[]=\$verdict;
      };
    };
  };
  \$conc=\$conceptset->next_concept();
};
sort(\$verdar);
@| @}


@d put the verdicts and-wise in an array  @{@%
\$conc=\$conceptset->first_concept();
\$verdar=array();
if(!(\$conc===FALSE)){
  if(count(\$conc->verdicts())>0){
    foreach(\$conc->verdicts() as \$key => \$verdict){
      if(!in_array(\$verdict, \$verdar)){
        \$verdar[]=\$verdict;
      };
    };
  };
};
\$conc=\$conceptset->next_concept();
while(!(\$conc===FALSE)){
  foreach(\$verdar as \$key => \$verdict){
     if(!(\$conc->is_relevant_verdict(\$verdict))){
       unset(\$verdar[\$key]);
     };
  };
  \$conc=\$conceptset->next_concept();
};
if(count(\$verdar)>0) sort(\$verdar);
@| @}




@d display the verdicts from the array @{@%
foreach(\$verdar as \$key => \$verdict){
  printf("<li>");
  @< print verdict as selectable item @>
  printf("</li>\n");
};
@| @}



@d print verdict as selectable item @{@%
printf( "<a class=ord href=\"index.php?%s\">%s</a>\n"
      , modified_querystring('m4_filenamekeyword',\$verdict)
      , \$verdict
      );
@| @}


@d display the verdicts in the clusterlist @{@%
if(\$handle=fopen("m4_casegrouplist/".\$clusterlist, "rb")){
@%  @< pemess @("<p>Opened m4_casegrouplist/".\$clusterlist.".</p>"@) @>
  \$fpnums=fgets(\$handle);
  printf("<ul>\n");
   while(!feof(\$handle)){
     \$verdict=trim(fgets(\$handle));
     if(preg_match("/^[A-Z]/i", \$verdict)>0){
       printf("<li>");
       @< print verdict as selectable item @>
       printf("</li>\n");
     };
   };
  printf("</ul>\n");
  fclose(\$handle);
};
@| @}



Print a header on top of the verdict-list. The function
\verb|tooltippeds| creates a tooltip with help.

@d print a header for the list of related cases @{@%
@< help-text voor verwantezaken @>
printf("<H2>%s</H2>\n", tooltippeds("Verwante zaken", \$helptext));
@| @}


@d help-text voor verwantezaken @{@%
\$helptext="Hieronder staan rechterlijke uitspraken over ";
\$helptext=\$helptext."zaken die op uw zaak lijken. ";
\$helptext=\$helptext."Als u er een van aanklikt zal hij ";
\$helptext=\$helptext."afgedrukt worden in het rechterpaneel.";
@| @}


If the user has already selected a file to be displayed, make a list
of the \qstring{selected} relevant concepts, that are highlighted in the
displayed verdict and a list of the other, \qstring{deselected} but relevant, concepts. The
concepts are clickable. The user can deselect a \qstring{selected} concept
or vice-versa. The \qstring{selected} concepts are highlighted in the same way
that relevant paragraphs are.

The numbers of the selected concepts are passed via the querystring
and stored in object \verb|\$conceptset|.
@% (section~\ref{sec:conceptsetclass}).

Split the list of concepts up in \emph{selected concepts} (the user may
deselect them) and \emph{unselected concepts} (the user may select them).

@%@d print a list of relevant concepts for this case @{@%
@%  \$concepthelp=new Concepthelptext();
@%  @< make lists of selected and unselected concepts @>
@%  if(\$handle=fopen("m4_casegrouplist/".\$clusterlist, "rb")){
@%    \$fpnums= explode(" ", trim(fgets(\$handle))); fclose(\$handle);
@%    if(count(\$fpnums)>0){ \$conceptcounter=0;
@%      @< print header for concepts list in document-mode @>
@%      @< print list of selected relevant concepts @>
@%      @< print list of unselected relevant concepts @>
@%    } else { 
@%      printf("<p>Er zijn geen geldige concepten.</p>\n");
@%    };
@%  };
@%@| @}
@%



Print the header with a tooltip that contains the following text: 

@d help-text voor aspecten @{@%
\$helptext="Hieronder staan juridische aspecten die op uw ";
\$helptext=\$helptext."probleem betrekking hebben. ";
\$helptext=\$helptext."Door op de bijbehorende &quot;aan&quot; te klikken ";
\$helptext=\$helptext."kunt u zien voor welke passages in de tekst ";
\$helptext=\$helptext." dit aspect belangrijk is.";
@| @}

@d print header for concepts list in document-mode @{@%
@< help-text voor aspecten @>
printf("<H2>%s</H2>\n", tooltippeds("Aspecten", \$helptext));
@| @}


Print the list of selected concepts, with a tooltipped header:

@d help-text voor geselecteerd @{@%
\$helptext="Onderstaande aspecten zijn voor uw probleem relevant. ";
\$helptext=\$helptext."De passages in de uitspraak in het rechterpaneel ";
\$helptext=\$helptext." waarin dit aspect relevant is zijn gekleurd weergegeven ";
\$helptext=\$helptext." Door op &quot;uit&quot; te klikken kunt u de kleuring ";
\$helptext=\$helptext."uitzetten.";
@| @}

@%@d print list of selected relevant concepts @{@%
@%@< print header for selected concepts list in document-mode @>
@%if(count(\$selectedconcepts)>0){
@%  @< make list of concepts @(\$selectedconcepts@,TRUE@) @>
@%};
@%@| @}

@d print header for selected concepts list in document-mode @{@%
@< help-text voor geselecteerd @>
printf("<H3>%s</H3>\n", tooltippeds("geselecteerd", \$helptext));
@| @}



The list of unselected concepts is very similar:

@d help-text voor gedeselecteerd @{@%
\$helptext="Onderstaande aspecten zijn voor uw probleem relevant";
\$helptext=\$helptext." Door bij maximaal~m4_maxactiveconcepts aspecten op";
\$helptext=\$helptext." &quot;aan&quot; te klikken kunt u in de uitspraak ";
\$helptext=\$helptext." in het rechterpaneel passages die over dit aspect gaan ";
\$helptext=\$helptext." gekleurd laten weergeven.";
@| @}

@d print list of unselected relevant concepts @{@%
@< print header for non-active concept list in document-mode @>
@< help-text voor gedeselecteerd @>
printf("<H3>%s</H3>\n", tooltippeds("niet geselecteerd", \$helptext));
if(count(\$unselectedconcepts)>0){
  @< make list of concepts @(\$unselectedconcepts@,FALSE@) @>
};
@| @}

@d print header for non-active concept list in document-mode @{@%
@< help-text voor gedeselecteerd @>
printf("<H3>%s</H3>\n", tooltippeds("niet geselecteerd", \$helptext));
@| @}



Get the concepts that are relevant for this case. Divide them up into
lists of selected/unselected concepts.

First, put the relevant concept numbers into array \verb|\$relevantfpnums|.
@d make lists of selected and unselected concepts @{@%
global \$conceptset;
if(\$handle=fopen("m4_casegrouplist/".\$clusterlist, "rb")){
  \$relevantfpnums= explode(" ", trim(fgets(\$handle)));
  fclose(\$handle);
};
@| \$relevantfpnums @}

Then, check for each of the relevant conceptnumbers whether they have
been user-selected or not, an write them in array
\verb|\$selectedconcepts| resp.\ \verb|\$unselectedconcepts|.

@d  make lists of selected and unselected concepts @{@%
\$connum=array_shift(\$relevantfpnums);
while(\$connum!=NULL){
  if(\$conceptset->is_active_concept(\$connum)){
    \$selectedconcepts[]=\$connum;
  } else {
    \$unselectedconcepts[]=\$connum;
  };
  \$connum=array_shift(\$relevantfpnums);
};
@| \$selectedconcepts \$unselectedconcepts @}

Make the lists as tables (not lists), because we have the macro that prints the
concepts as table entries. If selected concepts must be printed, the
second argument of this macro is equal to \verb|TRUE|, otherwise it it
equal to \verb|FALSE|.

Variable \verb|\$conceptcounter| counts the
number of \qstring{active} concepts. The macro assumes the presence of
variable \verb|\$conceptcounter| that contains the number of concepts
that have been listed thus far. If the active concepts are listed, and
there is more than a single active concept, display the back-ground
colours for passages that are relevant for combinations of concepts.

@d make list of concepts @{@%
printf("<table>\n");
while((\$conceptnum=array_shift(@1))!=NULL){
  \$conceptcounter++;
  \$seqn="p".telwoordvan(\$conceptset->concept_seqnum(\$conceptnum));
  \$frasn="f".telwoordvan(\$conceptset->concept_seqnum(\$conceptnum));
  if(@2){
    @< print pointer to selected concept @(\$conceptnum@,\$seqn@,\$frasn@) @>
  } else {
    @< print pointer to deselected concept @(\$conceptnum@,\$seqn@) @>
  };
};
if(@2 && (\$conceptcounter>1)){
  @< print combination colours @(\$conceptcounter@) @>
};
printf("</table>\n");
@| @}

Return the English word for the number in the argument.
@d php functions @{@%
function telwoordvan(\$i){
  switch(\$i){
    case 0: return "nul";
    case 1: return "one";
    case 2: return "two";
    case 3: return "three";
    case 4: return "four";
    case 5: return "five";
    case 6: return "six";
    case 7: return "seven";
    case 8: return "eight";
    case 9: return "nine";
  };
  return;
}
@| telwoordvan @}


Print the title of a concept as a clickable reference. Usually the
reference refers to the concept itself, but if a concept is \qstring{in use}
a click should switch the concept off.

This macro accepts the following two arguments:
\begin{description}
\item[@@1:] The number of the concept to
  be processed. Otherwise, exclude it from the querystring.
\item[@@2:] The \qstring{span class} of the concept for the paragraph.
\item[@@3:] The \qstring{span class} of the concept for highlighted words.
\end{description}

@d print pointer to selected concept @{@%
if (\$handle = fopen("m4_fingerprintfiltrunk".@1, "rb")) {
  \$concepttitle=rtrim(fgets(\$handle));
  if(@1>0){
    \$questr=\$conceptset->querystring_without_conceptnr(abs(@1), "d");
  } else {
    \$questr=\$_SERVER['QUERY_STRING'];
  };
  printf("<tr>\n");
  printf("  <td>%d</td>\n", \$conceptcounter);
  printf("  <td><a class=ord href=\"m4_webURL`'/index.php?%s\">Uit</a></td>\n",\$questr);
@%  printf("  <td><span class=\"%s\"><span class=\"%s\">%s</span></span></td>\n",@2,@3, \$concepttitle);
  printf("  <td><span class=\"%s\"><span class=\"%s\">%s</span></span></td>\n",
           @2,@3, \$concepthelp->tooltipstring(abs(@1)));
  printf("</tr>\n");
};
@| @}

When more than a single concept is active, show the back-ground
colours of texts that are are relevant for more than one concept.

@d print combination colours @{@%
if(@1>=2){
  printf("<tr>\n");
  printf("  <td /><td /><td><span class=\"m4_conceptparonetwo\">1 en 2</span></td>\n");
  printf("</tr>\n");
};
if(@1>=3){
  printf("<tr>\n");
  printf("  <td /><td /><td><span class=\"m4_conceptparonethree\">1 en 3</span></td>\n");
  printf("</tr>\n");
  printf("<tr>\n");
  printf("  <td /><td /><td><span class=\"m4_conceptpartwothree\">2 en 3</span></td>\n");
  printf("</tr>\n");
  printf("<tr>\n");
  printf("  <td /><td /><td><span class=\"m4_conceptparonetwothree\">1, 2 en 3</span></td>\n");
  printf("</tr>\n");
};
@| @}


Print the deselected concepts. If~m4_maxactiveconcepts or more
concepts are \emph{active} it is not possible to select one of the
deselected concepts.

@d print pointer to deselected concept @{@%
if (\$handle = fopen("m4_fingerprintfiltrunk".abs(@1), "rb")) {
  \$concepttitle=rtrim(fgets(\$handle));
  printf("<tr>\n");
  printf("  <td>%d</td>\n", \$conceptcounter);
  if(\$conceptset->active_concept_count>=m4_maxactiveconcepts){
     printf("  <td>--</td>\n");
  } else {
   \$questr=\$conceptset->querystring_with_conceptnr(@1, "d");
   printf("  <td><a class=ord href=\"m4_webURL`'/index.php?%s\">Aan</a></td>\n",\$questr);
  };
@%  printf("  <td>%s</td>\n", \$concepttitle);
  printf("  <td>%s</td>\n", \$concepthelp->tooltipstring(abs(@1)));
  printf("</tr>\n");
@%  if(@1>0){
@%     \$questr=\$conceptset->querystring_with_conceptnr(@1);
@%  } else {
@%      \$questr=\$_SERVER['QUERY_STRING'];
@%  };
@%  printf("  <td>%s</td>\n", \$concepttitle);
@%  printf("</tr>\n");
@%  printf("<tr><td><span class=\"%s\">",@2);
@%  printf("<a href=\"m4_webURL`'/index.php?%s\">%s</a>",\$questr,\$concepttitle);
@%  printf("</span></td></tr>\n");
};
@| @}


\subsubsection{The right panel}
\label{sec:documento_rightpanel}


The right panel displays a file if the user has selected one.
@d functions of index @{@%
function documento_rightpanelcontent(){
  \$filnam=parameter_value_of('m4_filenamekeyword');
  if(\$filnam==""){
    printf("<p>In het linkerpaneel staan de LJN nummers van
    rechterlijke uitspraken van zaken die verwant zijn aan de uwe.</p>\n");
    printf("<p>Klik op een van de codes om een zaak in te zien.</p>\n");
  } else {
    @< display the selected verdict @>
  };
};
@|documento_rightpanelcontent @}


\subsection{Ask the user for helptexts to edit}
\label{sec:edithelp}

When the user opens the back-door program, Provide a bit explanation
and provide the choice to edit texts for concepts or for legalese.

Display some help-texts and links to the proper pages.

\label{editnomodefunction}%
@d functions of backdoordir/index @{@%
function edit_nomode(){
  ?>
    <h1>Pas helpteksten  aan</h1>
<p> Met deze pagina kunt u hulp-teksten toevoegen of veranderen. Deze
    hulpteksten worden op zogenaamde \qstring{tooltips} afgedrukt bij titels
    van concepten.
</p>

    <h2>Pas hulp bij concept-titels aan</h2>
    <p>Bij ieder concept kan een tooltip met uitleg opgeroepen worden.
       U kunt bepalen wat de inhoud van die uitleg moet zijn.</p>

    <p><a class=ord href="<?php
          printf("%s", address_with_modified_querystring(m4_modekeyword, "c"));
          ?>"
        >
        Ik wil hulp-teksten bij concepttitels aanpassen
       </a>
    </p>
    
    <h2>Pas hulp bij trefwoorden aan</h2>
    <p>Woorden in uitspraken kunnen tooltips met uitleg krijgen.
       U kunt bepalen welke woorden uitleg moeten krijgen
       en wat de inhoud van die uitleg moet zijn.
    </p>

    <p><a class=ord href="<?php
          printf("%s", address_with_modified_querystring(m4_modekeyword, "l"));
          ?>"
        >
        Ik wil hulp-teksten bij trefwoorden aanpassen
       </a>
    </p>
    
  <?php
}
@| edit_nomode @}


\subsection{Edit helptexts for concepts}
\label{sec:concepthelp}

When the backdoor program is in \qstring{concept mode}, we have the
following possible situations:

\begin{enumerate}
\item This is the first screen in this mode. The user should pick a
  concept to be processed. In this situation there is no selected
  concept and there is no user-generated help-text to be processed.
\item The user has selected a concept, but not yet processed it. In
  this situation there is a selected concept, but no user-generated text.
\item The user has selected a concept and processed the help-text. In
  this case, there is a selected concept and there is user-generated text.
\end{enumerate}

Function \verb|edit_concept_mode| asks the user to pick a concept if
its argument is an empty string. Otherwise, the argument should
contain the number of the concept to be processed and the function
allows the user to do so.

@d  edit helptext for concepts @{@%
if(\$_POST['editedtext']!=''){
  @< write new concepttext @>
  edit_concept_mode("");
} else {
  edit_concept_mode(parameter_value_of("m4_selectionkeyword"));
};
@| @}



When the mode of the program is to edit helptexts for concept, first
we have to check whether the user delivered helptext already. In that
case, store the helptext in the right place and allow the user to edit
the text for another concept. Otherwise, we have to allow the user to
edit the text of a selected concept if the user selected a concept, or
to allow the user to pick a concept.

This goes in two stages: 1) select the concept text to be edited and
2) perform the editing. Query Parameter \verb|no| holds the number of
the concept to be edited.

\label{editconceptmodefunction}%
@d functions of backdoordir/index @{@%
function edit_concept_mode(\$conceptnum){
  if(\$conceptnum==""){
    @< present the concepts to be edited @>
  } else {
    @< allow to edit the concept helptext @>
@%    printf("<h1>Edit concept %d</h1>\n", parameter_value_of("m4_conceptnumkeyword"));
  };
}
@| edit_concept_mode @}

@d present the concepts to be edited @{@%
printf("<h1>Kies een van de concepten:</h1>\n");
\$concepthelptexts= new Concepthelptext();
printf("<ul>\n");
for(\$i=1;\$i<=m4_nrofconcepts; \$i++){
  printf("<li>%s\n", pointer_to_concept(\$i, \$concepthelptexts));
};
printf("</ul>\n");

@| @}


Make something like function \verb|old_pointer_to_single_concept|, but a
little different. One of the differences is, that we use
\verb|m4_selectionkeyword| instead of \verb|m4_conceptnumkeyword|.

@d functions of backdoordir/index @{@%
function pointer_to_concept(\$conceptnum, \$concepthelptexts){
  \$concepttitle=concepttitle(\$conceptnum);
   
  \$returnstring=" <a class=pah ";
  \$returnstring=\$returnstring.\$concepthelptexts->onmouseoverriedel(\$conceptnum);
  \$returnstring=\$returnstring." href=\"";
  \$returnstring=\$returnstring.address_with_modified_querystring("m4_selectionkeyword", \$conceptnum);
  \$returnstring=\$returnstring."\">";
  \$returnstring=\$returnstring.\$concepttitle;
  \$returnstring=\$returnstring."</a>";
  return \$returnstring;
}

@| @}


Edit the text for concept nr.~\verb|\$conceptnum|. 

@d allow to edit the concept helptext @{@%
\$concepthelptexts= new Concepthelptext();
printf("<h1>Edit concept %d</h1>\n", \$conceptnum);
printf("<h2>%s</h2>\n", concepttitle(\$conceptnum));
@%printf("<center>\n");
@< place the tinymce editor @(editedtext@,\$concepthelptexts->gettext(\$conceptnum)@)@>
@%printf("<form method="post">\n");
@%printf("<textarea name=\"content\" cols=\"50\" rows=\"15\">\n");
@%printf("%s\n", \$concepthelptexts->gettext(\$concepthelpnum));
@%printf("</textarea>\n");
@%printf("</form>\n");
@%printf("</center>\n");
@| @}

When the user provided help-text for a concept, write it in the storage.

Get the number of the concept from
the querystring and the revised
helptext from \verb|post|. 

@d write new concepttext @{@%
\$conceptnum=parameter_value_of("m4_selectionkeyword");
if(\$conceptnum==""){
  printf("<p>Could not process helptext</p>\n");
} else {
  \$concepthlp= new  Concepthelptext();
  \$concepthlp->insert_text(\$conceptnum, preprocessed_tooltiptext(\$_POST['editedtext']));
};
@| @}




\subsection{Edit helptexts for legalese}
\label{sec:editlegalese}

When the backdoor program is in \qstring{concept mode}, we have the
following possible situations:

\begin{enumerate}
\item This is the first screen in this mode. The user should pick a
  word for which the help-text must be processed or come up with a new
  word for which there is not yet help-text. In this situation there is no selected
  and there is no user-generated help-text to be processed.
\item The user has selected a word or asked to introduce a new word,
  but not yet processed it. In
  this situation there is a selected word (or a code that signifies
  that the user wants to introduce a new word), but there is no user-generated text.
\item The user has generated help-text for a word. The word itself
  resides either in the querystring or in \textsc{post} as a new
  word and there is user-generated text.
\end{enumerate}

Function \verb|edit_legalese_mode| asks the user to pick a word if
its argument is an empty string. Otherwise, the argument should
contain the number of the concept to be processed and the function
allows the user to do so.

\label{editlegalesemodefunction}%
@d edit helptext for legalese @{@%
if(\$_POST['editedtext']!=''){
  @< write new legatext @>
  edit_legalese_mode("");
} else {
  edit_legalese_mode(parameter_value_of("m4_selectionkeyword"));
};
@| @}



Allow to edit explanation of legalese words. If the argument is the
empty string, let the user pick an existing or a new word. Otherwise,
if the argument is the string m4_quotverb(m4_newlegaw), let the
user choose a word and create a helptext. If the argument is another
string, find the word in the \verb|Explaintexts| object and let the
user edit the helptext.

@d functions of backdoordir/index @{@%
function edit_legalese_mode(\$legaword){
  \$exptexts= new Explaintexts();
  if(\$legaword==""){
   @< present the explained words @>
  } else {
   @< allow to edit the word helptext @>
  };
}

@| edit_legalese_mode  @}


Open the file with the legalese words and present the words. 
@d present the explained words @{@%
printf("<h1>Kies een van de bestaande woorden of een nieuw woord.</h1>\n");
@| @}

Display a button to edit a new word

@d present the explained words @{@%
?>
</p>
   <a class=ord href="<?php
       printf("%s", address_with_modified_querystring("m4_selectionkeyword", "m4_newlegaw"));
       ?>"
   >
        Ik wil een woord toevoegen.
   </a>
<?php
@| @}



Present a table of 6 colums with the existing legal words. variable
\verb|\$colp| points to the column that has to be filled.

@d present the explained words @{@%
if(\$exptexts->wordcount()>0){
  \$exptexts->reset();
  while(\$exptexts->getnextword()!=""){
    printf("<table>\n");
    \$colp=1;
    \$rowp=0;
    if(\$colp==1) printf("<tr>\n");
    printf(" <td>\n");
    printf("%s\n", pointer_to_current_helpword(\$exptexts));
@%     @< print the help-word with pointer and tooltip @>
    printf(" </td>\n");
    \$colp++;
    if(\$colp==7){
      printf("</tr>\n");
      \$colp=1;
    };
  };
  printf("</table>\n");
};
@| @}

Create an \verb|<a>| tag with a tooltip, that sets the word to be edited.
@d functions of backdoordir/index @{@%
function pointer_to_current_helpword(\$exptexts){
  \$rs="<a class=pah ";
  \$rs=\$rs.\$exptexts->onmouseoverriedel();
  \$rs=\$rs." href=\"";
  \$rs=\$rs.address_with_modified_querystring("m4_selectionkeyword",\$exptexts->getcurrentword());
  \$rs=\$rs."\">";
  \$rs=\$rs.\$exptexts->getcurrentword();
  \$rs=\$rs."</a>";
  return \$rs;
}

@| @}



Write the legalese word or make a spot where the user supplies the
word. Place the tinyMCE editor with the helptext as it currently is.
@d allow to edit the word helptext @{@%
if(\$legaword=="m4_newlegaw"){
  printf("<h1>Maak helptekst voor een nieuw woord</h1>\n");
} else {
  printf("<h1>Wijzig helptekst voor <b>%s</b></h1>\n", \$legaword);
};
@< make a form to edit the legalese @>
@| @}


Create a form for user input. If the user has to introduce a new word,
create text-field for that purpose. Create an area to edit text and
fill it with the help-text if it exists. The user may also remove the
helptext for this word.

@d make a form to edit the legalese @{@%
printf("<form method=\"post\" action=\"%s\">\n", address_with_unmodified_querystring());
@%if(\$legaword=="m4_newlegaw"){
@%  printf("Nieuw woord: <input type=text name=\"newlegaw\" size=30>\n");
@%} else {
@%  printf("Verwijder het woord: <input type=radio name=\"remove\" value=\"y\" />\n");
@%};
if(\$legaword=="m4_newlegaw"){
  printf("Nieuw woord: <input type=text name=\"newlegaw\" size=30>\n");
} else {
  printf("Woord: <input type=text name=\"newlegaw\" value=\"%s\" size=30>\n", \$legaword);
  printf("Verwijder het woord: <input type=radio name=\"remove\" value=\"y\" />\n");
};
printf("<textarea id=\"editedtext\" name=\"editedtext\" rows=\"15\" cols=\"80\">");
if(\$legaword!="m4_newlegaw"){
  \$exptexts->make_current_word(\$legaword);
  printf("%s", \$exptexts->getexplanation());
}printf("</textarea>\n");
printf("<br />");
printf("<input type=\"submit\" name=\"save\" value=\"Submit\" />\n");
printf("</form>\n");
@| @}

Process information from the user. When the user pressed the
\qstring{remove word}, remove the word from the database. Otherwise,
get the word to be processed from \qstring{post} is it resides there
or from the querystring. Insert the word and the text into the
database.

@d write new legatext @{@%
\$exptext=new Explaintexts();
\$newlegaw=strtolower(\$_POST['newlegaw']);
if(\$newlegaw=="") \$newlegaw=\$legaword;
if(\$_POST['remove']=="y"){
  \$exptext->remove(\$newlegaw);
} else {
  \$exptext->insert_text(\$newlegaw, preprocessed_tooltiptext(\$_POST['editedtext']));
};
@| @}


\chapter{Communication between the pages}
\label{chap:communication}

The display script consists of a single \textsc{php} web page. To
perform actions the script evokes itself, with suitable parameters in
the \textsc{url}. Most of the time the user interacts with the program
by clicking on a \verb|<a>| tag that has the page itself as target,
followed by a query-string with parameters that tell the
program what to do.

Currently the following parameters are communicated from page to page:

\begin{description}
\item[mode:] Case-oriented mode of concept-oriented mode
  (cf.~section~\ref{sec:opmodes}). In the backdoor program the mode
  indicates whether the user wants to edit concept explanations or
  legalese explanations.
\item[m4_filenamekeyword:] The name of the verdict to be displayed.
\item[m4_conceptnumkeyword:] The \qstring{active} concepts that have to be
  illustrated in the verdict, or that have to be explained in
  concept-oriented mode.
@%\item[m4_clusterkeyword:] The name of a \qstring{case-group} (a set of concepts
@%  and a set of verdicts for which the  concepts are relevant. See section~\ref{sec:clustered}).
\end{description}


\subsection{Manage the query-string}
\label{sec:managequery}

The querystring is in \php{} scripts available as variable
\verb|\$_SERVER['QUERY_STRING']|. However, we use functions to
encapsulate the querystring.

The following functions will be provided:

\begin{description}
\item[parameter\_value\_of(par):] Return the value of parameter \verb|par|.
  If the parameter is not present in the
  string, return an empty string.
\item[modified\_querystring(par, val):] Return a query-string in which
  parameter \verb|par| has value \verb|val|. The query-string can be
  pasted in the target of an \verb|<a>| tag.
\item[cascmodified\_querystring(ques, par, val):] return query-string
  \texttt{ques} in which parameter \verb|par| has value \verb|val|.
\item[address\_with\_modified\_querystring(par, val):] As
  \verb|modified_querystring|, but generates a full address with querystring. 
\item[address\_with\_unmodified\_querystring(par, val):] Similar to
  \verb|address_with_modified_querystring|. Needed for forms that
  communicate data with the \textsc{post} mechanism.
\item[remove\_filename\_from\_querystring(questr):] Return the
  querystring in the argument, but withe the file-name removed. 
\end{description}

The following function gets the value of one of the parameters from the
query-string. If the parameter is not present in the string, it returns an empty string.

@d php functions @{@%
function parameter_value_of(\$parnam){
  parse_str(\$_SERVER['QUERY_STRING'], \$params);
  return \$params[\$parnam];
}

@| parameter_value_of @}

@%@d php functions @{@%
@%function modified_querystring(\$parnam, \$parval){
@%  parse_str(\$_SERVER['QUERY_STRING'], \$params);
@%  if(\$parval==""){
@%    unset(\$params[\$parnam]);
@%  } else {
@%    \$params[\$parnam]=\$parval;
@%  };
@%  return http_build_query(\$params);
@%}
@%@| modified_querystring  http_build_query @}

@d php functions @{@%
function modified_querystring(\$parnam, \$parval){
  return  cascmodified_querystring(\$_SERVER['QUERY_STRING'], \$parnam, \$parval);
}

@| modified_querystring @}

@d php functions @{@%
function cascmodified_querystring(\$ques, \$parnam, \$parval){
  parse_str(\$ques, \$params);
  if(\$parval==""){
    unset(\$params[\$parnam]);
  } else {
    \$params[\$parnam]=\$parval;
  };
  return http_build_query(\$params);
}

@| cascmodified_querystring @}


@d php functions @{@%
function address_with_modified_querystring(\$parnam, \$parval){
  return m4_ikzelf."?".modified_querystring(\$parnam, \$parval);
}
@| @}

@d php functions @{@%
function address_with_unmodified_querystring(){
  return m4_ikzelf."?".\$_SERVER['QUERY_STRING'];
}
@| @}


@d php functions @{@%
function remove_filename_from_querystring(\$questr){
  parse_str(\$questr, \$params);
  unset(\$params["m4_filenamekeyword"]);
  return http_build_query(\$params);
}

@| remove_filename_from_querystring @}

\subsection{Program mode}
\label{sec:mode}

The first thing that the script has to do, is to find out about the
mode. The display program has the three modes \emph{concept-oriented},
\emph{document-oriented} or \emph{no-mode} (initial state, enables the user to
select a mode). The backdoor program has the modes \emph{concepts},
\emph{legalese} or \emph{no-mode}. The mode is passed in the
query-string and can be found with function \verb|parameter_value_of|
(cf.~section~\ref{sec:managequery}). For each of the mode there is a
function that paints the window.

\label{contentvanindex}%
@d content van index @{@%
if(parameter_value_of('m4_modekeyword')=="c"){
    display_conceptorientedmode();
} else {
  if(parameter_value_of('m4_modekeyword')=="d"){
    display_documentorientedmode();
  } else { 
      display_nomode();
  };
};
@| @}


The help-editing program is slightly more complicated, because in that
case, edited help-texts are communicated by way of the \verb|post|
mechanism. There are two ways to invoke the \qstring{select concept} or the
\qstring{select word} window in figure~\ref{fig:helpeditflow}:

\begin{enumerate}
\item From above. The mode parameter has been set, but no concept
  resp.{} word has yet been selected and no text has been returned.
\item From below. The mode parameter has been set, a concept resp.{}
  word has been selected and edited text has been returned. 
\end{enumerate}

The lowest windows should be invoked if the mode parameter has been
set, a concept or word has been selected or the request to edit help
for a new word has been made, but no text has been returned.

So, we have the following parameters:\par
\begin{tabular}{lp{10cm}}
  m4_modekeyword       & Empty, \verb|c| (concept) or \verb|l| (legalese). \\
  m4_selectionkeyword  & Number of the concept or legalese word
                         to edit text for, or m4_newlegaw, to edit text for
                         a new legalese word.\\
\end{tabular}

and we may have user-generated text, that is returned by the post
mechanism. The function \verb|edit_concept_mode| invokes the
\emph{select concept} window if it's argument is an empty string and it
invokes the \emph{edit concept} if it's argument is the number of a
selected concept. The function \verb|edit_legalese_mode| works in an
analogous way.

\label{backdoorcontent}%
@d content of backdoordir/index @{@%
if(parameter_value_of('m4_modekeyword')=="c"){
  @< edit helptext for concepts @>
} else {
  if(parameter_value_of('m4_modekeyword')=="l"){
    @< edit helptext for legalese @>
  } else {
      edit_nomode();
  };
};
@}


\chapter{Annotation and help}
\label{chap:annothelp}

To provide implicit and explicit help to the user of the programs we
will highlighting, tooltips and helptexts.

\section{Highlighting}
\label{sec:highlighting}

Highlighting means, that some of the texts-strings are typeset in a
different font, in a different colour or on a different background
colour that the strings in it's environment. Highlighting occurs
especially in verdicts, where relevant paragraphs are typeset in a
striking background colour and relevant words in striking foreground
colours. For different concepts or different combinations of concepts,
different colours will be used.  However, if $n$ concepts are relevant
for a certain document, the number of colours explodes to $2^n$.
Therefore, we will restrict to a maximum of three concepts to be
marked in a single document.

The concepts that are used to mark-up the document are called the
\qstring{active} concepts. The active concepts are ordened by numbers.
To colour the paragraph, wrap it into a \verb|span| tag of a
predefined class and define the background colour of that class in a
style-sheet element.

The name of the span classes is derived from the order-numbers in a
way that they can easily be automatically generated.

\begin{tabular}{rl}
\textbf{Nr.} & \textbf{span-class} \\
-      & m4_conceptparnull         \\
1      & m4_conceptparone          \\
2      & m4_conceptpartwo          \\
3      & m4_conceptparthree        \\
1,2    & m4_conceptparonetwo       \\
1,3    & m4_conceptparonethree     \\
2,3    & m4_conceptpartwothree     \\
1,2,3  & m4_conceptparonetwothree 
\end{tabular}

Use a colour-circle to determine which colour to use. The single-concept paragraphs are
coloured in green, red and blue. The double-concept paragraphs are 
coloured with in-between colours and triple-concept paragraphs are
coloured in gray.



@d style sheet elements @{@%
.m4_conceptparnull {
  background: m4_white;
}

.m4_conceptparone {
  background: m4_paleweakgreen;
}

.m4_conceptpartwo {
  background: m4_paleweakred;
}

.m4_conceptparthree {
  background: m4_paleweakblue;
}

.m4_conceptparonetwo {
  background: m4_paleweakyellow;
}

.m4_conceptpartwothree {
  background: m4_paleweakmagenta;
}

.m4_conceptparonethree {
  background: m4_paleweakcyan;
}


.m4_conceptparonetwothree {
  background: m4_palegrey;
}

@| @}


The relevant words and phrases are coloured in a similar way, by
wrapping in a span tag. The words are coloured for the concept for which
they have the highest weight-factor in the fingerprint. The colour is
more intense than that of the paragraph:

@d style sheet elements @{@%

.m4_conceptwordone {
  font-weight:bold;
  color: m4_green;
@%  background: m4_paleweakgreen;
}

.m4_conceptwordtwo {
  font-weight:bold;
  color: m4_red;
@%  background: m4_paleweakred;
}

.m4_conceptwordthree {
  font-weight:bold;
  color: m4_blue;
@%  background: m4_paleweakblue;
}

.m4_conceptwordonetwo {
  font-weight:bold;
  color: m4_donkergeel;
@%  background: m4_paleweakyellow;
}

.m4_conceptwordtwothree {
  font-weight:bold;
  color: m4_darkmagentav;
@%  background: m4_paleweakmagenta;
}

.m4_conceptwordonethree {
  font-weight:bold;
  color: m4_darkdullcyan;
@%  background: m4_paleweakcyan;
}

.m4_conceptwordonetwothree {
  font-weight:bold;
  color: m4_obscuregrey;
@%  background: m4_palegrey;
}

@| @}

\section{Tooltips}
\label{sec:tooltips}

Tooltips are windows that pop up when the user moves the mouse on top
of a word for which explanation is available. This section provides the
function \verb|tooltipped| that prints a \textsc{html} \verb|<a>| tag
for a tooltip, and a function \verb|preprocessed_tooltiptext| that
makes a text string suitable to be included as text for a tooltip.

\subsection{Walter Zorn's tooltip utility}
\label{sec:walterzorn}

A convenient tool to implement tooltips is
\href{http://www.walterzorn.com/tooltip/tooltip_e.htm}{Walter Zorn's
  Javascript} tooltip%
\index{tooltip} library.

Use this as follows:

\begin{enumerate}
\item Download \verb|wz_tooltip.zip| from
  \url{http://walterzorn.com/tooltip/tooltip_e.html#download/} and
  unpack it.
\item Move file \verb|wz_tooltip.js| to some place where it can be
  found.
\item Load it into the html page, preferably right after the
  \verb|<body>| tag.
\item To have a window popping up with  \qstring{some text} in it, activate
  Javascript function \verb|Tip("Some text")| (e.g.\ in an
  \verb|onmouseover| command. Note, that quotes may only appear in the
  pop-up text as m4_quotverb(`&quot;').
\item Another way to provide text for a tool-tip, is to write it,
  wrapped between \verb|<span>| tags, somewhere in the document. Use
  in that case function \verb|TagToTip('helptext')| instead of
  \verb|Tip|. The argument (\verb|helptext|) is the class of the
  \verb|<span>| tags in which the text has been wrapped. The tooltip
  function \qstring{eats} the original text: it should not appear somewhere in
  the document itself.
\end{enumerate}

We are stubborn, and load the library at the end of the body, because
we already have a facility to load javascripts there.

@d init javascript @{@%
printf("<script type=\"text/javascript\" src=\"m4_javascriptURL/wz_tooltip.js\"></script>\n");
@| @}

\subsection{Tooltip style}
\label{sec:tooltipstyle}

To associate a tooltip to a text on the display, wrap the text into an
\textsc{html} \verb|<a>| tag in which the \verb|Tip| function is the
content of an \verb|onmouseover| argument.

We will adopt the policy to underline%
\index{underline}\index{tooltip|underline}
texts for which a tooltip is available and do not apply a special
colour. Therefore, we need to discriminate between \verb|<a>| tags
with (hyper)links, \verb|<a>| tags with tooltips and \verb|<a>| tags
with hyperlinks and tooltips. We define the subclasses
\verb|a.ord|, \verb|a.nepa| resp.{} \verb|pah| (Point And Help).

@d style sheet elements @{@%
a.ord {
      text-decoration:none;
      font-weight:bold; 
      color:#b00;
    }

a.nepa {
      text-decoration:underline;
    }

a.pah {
      text-decoration:underline;
      font-weight:bold; 
      color:#b00;
    }

@| @}

\subsection{Tooltip PHP functions}
\label{sec:tooltipphp}

\begin{description}
\item[tooltipped(text, helptext):] print \verb|<a>| tag with contents \texttt{text} and tooltip with text \texttt{helptext}, without target.
\item[tooltippeds(text, helptext):] return \verb|<a>| tag with contents \texttt{text} and tooltip with text \texttt{helptext}, without target.
\item[reference\_with\_tooltips(text, helptext, target):] return \verb|<a>| tag with contents \texttt{text} and tooltip with text \texttt{helptext}, that points to \texttt{target}
\end{description}

\textsc{Php} function \verb|tooltipped| prints a text wrapped in an
\verb|<a>| tag that generates a tooltip. It receives two
arguments:
\begin{enumerate}
\item The text to be \qstring{tooltipped};
\item A string that contains the text that should appear in the tooltip.
\end{enumerate}

This function uses the \verb|Tip| function (not the \verb|TagToTip|
function because this can become troublesome when facilities like
\verb|ajax| are used).

Note that the \verb|<a>| tag does not have a \verb|href| argument.
This is, because that argument causes the text to be displayed in
special colours, and we don't want that. We want to use underline
instead of colours, and I don´t know of a way to paint an
\verb|<a>| tag content in the colour of the next higher level in the
hierarchy.  It might be, that the absence of the \verb|href| argument
causes trouble in some browsers.

@d php functions @{@%
function tooltipped(\$doctext, \$tttext){
  printf("<a class=nepa onmouseover=\"Tip('%s')\">%s</a>\n", \$tttext, \$doctext);
}

@| tooltipped @}

@d php functions @{@%
function tooltippeds(\$doctext, \$tttext){
  return "<a class=nepa onmouseover=\"Tip('".\$tttext."')\">".\$doctext."</a>\n"; 
@%  printf("<a class=nepa onmouseover=\"Tip('%s')\">%s</a>\n", \$tttext, \$doctext);
}
@| tooltippeds @}


@%@d php functions @{@%
@%function tooltippeds_annot(\$doctext, \$tttext, \$styl){
@%  return "<a class=".\$styl." onmouseover=\"Tip('".\$tttext."')\">".\$doctext."</a>\n"; 
@%@%  printf("<a class=nepa onmouseover=\"Tip('%s')\">%s</a>\n", \$tttext, \$doctext);
@%}
@%@| tooltippeds_annot @}



@d php functions @{@%
function reference_with_tooltips(\$text, \$tttext, \$target){
  \$rets=       "<a class=pah ";
  \$rets=\$rets.  "onmouseover=\"Tip('".preprocessed_tooltiptext(\$tttext)."')\" ";
  \$rets=\$rets.  "href='".\$target."'";
  \$rets=\$rets.">";
  \$rets=\$rets.  \$text;
  \$rets=\$rets."</a>";
  return \$rets;
@%  return "<a class=pah onmouseover=\"Tip('".preprocessed_tooltiptext(\$tttext)."')\"  href='".\$target."' >".\$doctext."</a>\n"; 
}

@| reference_with_tooltips @}


Text for tooltips may not contain linefeed or quote characters. The
following function replaces the linefeeds by spaces and the quotes by
m4_quotverb(`&quot;').

@d php functions @{@%
function preprocessed_tooltiptext(\$intext){
  \$pattern=array(0 => "/\n/", 1 =>"/\"/");
  \$replacement=array(0 => " ", "&quot;");
  ksort(\$pattern);
  ksort(\$replacement);
  return preg_replace(\$pattern, \$replacement, \$intext);
}

@| @}



@%The following function uses the \verb|TagToTip| form. The second
@%argument is a label for the span tags
@%
@%@d php functions @{@%
@%function ttooltipped(\$doctext, \$label, \$tttext){
@%  printf("<a onmouseover=\"TagToTip('%s')\">%s</a>\n", \$tttext, \$doctext);
@%}
@%@| @}


@%\subsection{Tooltips to explain the web-page}
@%\label{sec:webpagetooltips}
@%
@%Provide pop-up windows with help info in elements of the web-page like
@%titles.
@%
@%@d functions of index @{@%
@%function help_element(\$elementtext, \$helptext){
@% return "<a class=nepa onmouseover=\"Tip('".\$helptext."')\">".\$elementtext." </a>\n";
@%};
@%@| @}



\section{Manage helptexts }
\label{sec:managehelptexts}

Most of the help-text that e.g.{} pop up in tooltips are stored in
help-files. Generally, a help-file consists of lines that begin with
an identifier, followed by a \verb|tab| character, followed by the
text for a single item. The following sections describe a class to
manage such files and a sub-class to manage a file that contains descriptions
of concepts. The latter will become obsolete, because these texts will
be retrieved from the ontology.


\subsection{A class for help-texts}
\label{sec:helptextclass}

The following class Helptext loads a help-file and makes the helptexts
available. It provides the following methods:

\begin{description}
\item[Helptext] Constructor that does practically nothing.
\item[fill\_with\_file:] Reads a file with help-texts (First argument
  is filename).
\item[save:] Back-up a file (First argument is
  filename) and store the help-texts in a new version of the file.
\item[gettext:] Return the text that is associated with the first argument.
\item[printtooltip:] Print a tooltip tag. The first argument is the
  pointer to the helptext and the second argument is the text to be tooltipped.
\item[onmouseoverriedel:] Produce a string with an \qstring{onmouseover}
  statement to be pasted into an \verb|<a>| tag.  
\end{description}

@d php functions @{@%
class Helptext {
  var \$texts;
  var \$empty=TRUE;

  function Helptext(){
    \$this->texts[0]="empty";
  }

  @< methods of the helptext class @>
}

@| Helptext @}

Read a tab-separated file with helptexts. Make empty if this is not
successful.

@d  methods of the helptext class @{@%
function fill_with_file(\$filnam){;
  unset(\$this->texts);
  \$this->empty=TRUE;
  if(\$handle=fopen(\$filnam,  "rb")){
    \$this->empty=feof(\$handle);
    while(!feof(\$handle)){
      \$linarr = explode("\t", rtrim(fgets(\$handle)));
      if(\$linarr[0]!=""){
        \$this->texts[\$linarr[0]]=\$linarr[1];
      };
    };
    fclose(\$handle);
  };
}

@| fill_with_file @}

@d methods of the helptext class @{@%
function save(\$filpath){
  \$backupfilpath=\$filpath.".old";
  if (!copy(\$filpath, \$backupfilpath)) {
    printf("<p> Kopie van %s naar %s maken is mislukt. </p>\n", \$filpath,  \$backupfilpath);
  } else {
    if(\$handle = fopen(\$filpath, "w")){
      foreach(\$this->texts as \$key => \$value){
        \$outs=\$key."\t".\$value."\n";
        fwrite(\$handle, \$outs);
      };
      fclose(\$handle);
      return TRUE;
    } else {
      return FALSE;
    };
  };
}

@| save @}

Return a string with the helptext that belongs to an item.

@d methods of the helptext class @{@%
function gettext(\$item){
  return \$this->texts[\$item];
}

@| gettext @}

Print a tag with a tooltip. Arguments:
\begin{enumerate}
\item The pointer to the text to be displayed in the tooltip;
\item The text to be printed between the \verb|<a>| and the
  \verb|</a>| tags.
\end{enumerate}

@d methods of the helptext class @{@%
function printtooltip(\$pointer, \$label){
  tooltipped(\$label, \$this->texts[\$pointer]);
}

@| printtooltip @}


Sometimes, we build a special \verb|<a>| tag, e.g.{} that really
points to something. In that case, use the following method to produce
a string with the \qstring{onmouseover} argument.

Get a string with the \qstring{onmouseover} argument, to be pasted in an
\verb|<a>| tag.

@d methods of the helptext class @{@%
function onmouseoverriedel(\$pointer){
  return "onmouseover=\"Tip('".\$this->texts[\$pointer]."')\"";
}

@| onmouseoverriedel @}


\subsection{Help texts for concepts}
\label{sec:concepthelp}

Explain concepts in tooltips or otherwise. The help-texts are listed
in a file, \url{m4_helpdir/concepthelp}. This file consists of
lines, in which fields are separated by tab characters. The first
field is the number of the concept and the
second field the explanation. Here a prototype for this file:

@o m4_helpdir/prototype.concepthelp -t @{@%
1	Nog geen helptekst voor concept 1
2	Nog geen helptekst voor concept 2.
3	Nog geen helptekst voor concept 3.
4	Nog geen helptekst voor concept 4.
5	Nog geen helptekst voor concept 5.
6	Nog geen helptekst voor concept 6.
7	Nog geen helptekst voor concept 7.
8	Nog geen helptekst voor concept 8.
9	Nog geen helptekst voor concept 9.
10	Nog geen helptekst voor concept 10.
11	Nog geen helptekst voor concept 11.
12	Nog geen helptekst voor concept 12.
13	Nog geen helptekst voor concept 13.
14	Nog geen helptekst voor concept 14.
15	Nog geen helptekst voor concept 15.
16	Nog geen helptekst voor concept 16.
17	Nog geen helptekst voor concept 17.
18	Nog geen helptekst voor concept 18.
19	Nog geen helptekst voor concept 19.
20	Nog geen helptekst voor concept 20.
21	Nog geen helptekst voor concept 21.
22	Nog geen helptekst voor concept 22.
23	Nog geen helptekst voor concept 23.
24	Nog geen helptekst voor concept 24.
25	Nog geen helptekst voor concept 25.
26	Nog geen helptekst voor concept 26.
27	Nog geen helptekst voor concept 27.
28	Nog geen helptekst voor concept 28.
29	Nog geen helptekst voor concept 29.
30	Nog geen helptekst voor concept 30.
31	Nog geen helptekst voor concept 31.
32	Nog geen helptekst voor concept 32.
33	Nog geen helptekst voor concept 33.
34	Nog geen helptekst voor concept 34.
35	Nog geen helptekst voor concept 35.
36	Nog geen helptekst voor concept 36.
37	Nog geen helptekst voor concept 37.
38	Nog geen helptekst voor concept 38.
39	Nog geen helptekst voor concept 39.
@| @}

Handle this file with a subclass of the Helptext class:

@d php functions @{@%
class Concepthelptext extends Helptext{
  var \$chelpfilnam="m4_helpdir/concepthelp";

  @< methods of the Concepthelptext class @>

}
@| Concepthelptext @}

The class provides the following methods:

\begin{description}
\item[Concepthelptext:] Loads the texts from \verb|m4_helpdir/concepthelp|.
\item[save:] Without argument.
\item[insert\_text:] Renews the text that belongs to the concept
  number of the first argument with the text string in the second argument.
\item[printtooltip:] Prints an \verb|<a>| tag that contains the title
  of the concept with a tooltip. 
\end{description}

The following constructor of the class reads the file.

@d methods of the Concepthelptext class @{@%
function Concepthelptext(){
  parent::fill_with_file(\$this->chelpfilnam);
}
@| @}

Write a text-file. Return a boolean that reflects whether this has
been successful.

@d methods of the Concepthelptext class @{@%
function save(){
  return parent::save(\$this->chelpfilnam);
}
@| save @}


@%@d methods of the Concepthelptext class @{@%
@%function write_to_file(){
@%  \$bakfil=\$this->chelpfilnam.".old";
@%  if (!copy(\$this->chelpfilnam, \$bakfil.)) {
@%    print ("Backup maken mislukt.<br>\n");
@%  } else {
@%    if(\$handle = fopen(\$this->chelpfilnam, "w")){
@%      for(\$i=1;\$i<=m4_nrofconcepts;\$i++){
@%        \$outs="".\$i."\t".\$this->texts[\$i];
@%        fwrite(\$handle, \$outs);
@%      };
@%      fclose(\$handle);
@%      return TRUE;
@%    } else {
@%      return FALSE;
@%    };
@%  }
@%}
@%
@%@| @}

Accept a new or modified help-text and save it.

@d methods of the Concepthelptext class @{@%
function insert_text(\$ptr, \$text){
  \$this->texts[\$ptr]=\$text;
  \$this->save();
}

@| @}


Create a tooltip. Override the base method, because we need to get the
name of the concept from the fingerprint file.
The argument is the number of the fingerprint.

@d methods of the Concepthelptext class @{@%
function printtooltip(\$pointer){
  \$concepttitle=concepttitle(\$pointer);
  tooltipped(\$concepttitle, \$this->texts[\$pointer]);
}

@| printtooltip @}

Create in a similar way a string with a tooltip. 

@d methods of the Concepthelptext class @{@%
function tooltipstring(\$pointer){
  \$concepttitle=concepttitle(\$pointer);
  return tooltippeds(\$concepttitle, \$this->texts[\$pointer]);
}
@| tooltipstring @}

\subsection{Help texts for legalese}
\label{sec:legalesehelp}

The user can be helped by explanations of legal words. To this end we
have a file, \url{m4_legalesefil}, that contains legalese words and their
explanations. This file consists of texts lines that start with a
legal word to be explained, followed by a \qstring{tab} character , followed
by an explaining text. Create a class to load the contents of this
file and to make it available. The class contains arrays to store the
legalese words and the explanations. There is also an array to count
the number of times that each word has actually been used.

This class should actually be a subclass of the Helptext
class. However, I made this class first and it works. Therefore, I
leave it as it is.

The Explaintexts class provides the following methods:

\begin{description}
\item[Explaintexts:] Constructor. Reads the texts from  \url{m4_legalesefil}.
\item[save:] Save the texts in \url{m4_legalesefil}.
\item[wordcount:] Return number of explained words. 
\item[reset:] Resets the object (in order to go over all the legalese
  words again).
\item[getnextword:] return next legalese word.
\item[getcurrentword:] return the legalese word that the internal
  pointer points to.
\item[make\_current\_word:] Make the word in the argument the current word.
\item[getexplanation:] get the explanation text that belongs to the
  current word.
\item[report\_times\_found:] update the registration of the number of
  times that the current word has been found.
\item[times\_found:]  report the number of times that the last word
  has been found.
\item[explain\_texts] return the help-texts of words that have been
  used if a form that is suitable for tooltips.
\item[onmouseoverriedel:] Create an onmouseover tag with the help-text
  of the current word.
\item[wordtotooltip:] Return a string that is similar to the string in
  the first argument, but in which the legalese words have been
  replaced by \qstring{tooltipped} words that provide explanations.
\item[insert\_text:] Insert new text (arg~2) for a new or existing word (arg~1).
\item[remove:] Remove a word with its explanation.
\end{description}


@d php functions @{@%
class Explaintexts{
  var \$words;
  var \$explanations;
  var \$wordcount;
  var \$wordsstored=0;
  var \$wordpointer=1;

@< methods of the Explaintexts class @>
};
@| Explaintexts @}

On initialisation, read the texts from \url{m4_legalesefil}.

@d methods of the Explaintexts class @{@%
function Explaintexts(){
  \$this->wordsstored=0;
  if(\$legahandle = fopen("m4_legalesefil", "rb")){
    while(!feof(\$legahandle)){
      \$legarr = explode("\t", rtrim(fgets(\$legahandle)));
      if(\$legarr[0]!=""){
        \$this->wordsstored++;
        \$this->words[\$this->wordsstored]=\$legarr[0];
        \$this->explanations[\$this->wordsstored]=\$legarr[1];
      };
    };
    fclose(\$legahandle);
  };
}

@| Explaintexts @}

@d methods of the Explaintexts class @{@%
function save(){
  \$backupfilpath= "m4_legalesefil".".old";
  if (!copy("m4_legalesefil", \$backupfilpath)) {
    printf("<p> Kopie van %s naar %s maken is mislukt. </p>\n",
                 "m4_legalesefil",  \$backupfilpath
          );
    return FALSE;
  };
  if(\$handle = fopen("m4_legalesefil", "w")){
    \$this->reset();
    while(\$this->getnextword()!=""){
      \$outs=\$this->words[\$this->wordpointer]."\t".\$this->explanations[\$this->wordpointer]."\n";
      fwrite(\$handle, \$outs);
    };
    fclose(\$handle);
    return TRUE;
  };
}

@| save @}



@d methods of the Explaintexts class @{@%
function wordcount(){
  return \$this->wordsstored;
}

@| wordcount @}



Reset the object.

@d methods of the Explaintexts class @{@%
function reset(){
  for(\$i=1;\$i<=\$this->wordsstored; \$i++) \$this->wordcount[\$i]=0;
  \$this->wordpointer=0;
  return;
}
@| reset @}

@d methods of the Explaintexts class @{@%
function getnextword(){
 if(\$this->wordpointer<=\$this->wordsstored) \$this->wordpointer++;
 if(\$this->wordpointer>\$this->wordsstored){
   return "";
 } else {
   return \$this->words[\$this->wordpointer];
 };
}
@| getnextword @}

@d methods of the Explaintexts class @{@%
function getcurrentword(){
 if(\$this->wordpointer>\$this->wordsstored){
   return "";
 } else {
   return \$this->words[\$this->wordpointer];
 };
}
@| getcurrentword @}


Make the internal pointer point to the record with the helptext of the
word in the argument. Return the word if this help-text exists or
return an empty string.

@d methods of the Explaintexts class @{@%
function make_current_word(\$word){
  \$this->reset();
  while((\$this->getnextword()!="") && (\$this->getcurrentword()!=\$word)){
  };
  return \$this->getcurrentword();
}

@|make_current_word @}


Get the explanation of the last retrieved word.

@d methods of the Explaintexts class @{@%
function getexplanation(){
 if(\$this->wordpointer>\$this->wordsstored){
   return "";
 } else {
   return \$this->explanations[\$this->wordpointer];
 };
}
@| getexplanation @}

Report how many times the last retrieved word has been found in a text.

@d methods of the Explaintexts class @{@%
function report_times_found(\$times){
 \$this->wordcount[\$this->wordpointer]+=\$times;
}

@| report_times_found @}

Get the number of times that the last retrieved word has been found.

@d methods of the Explaintexts class @{@%
function times_found(){
 return \$this->wordcount[\$this->wordpointer];
}

@| times_found @}

Produce strings with the the explaining texts. If a word has been
used, write out the explanation between \verb|<span>| tags with the
word to be explained as \textsc{id}.

@d methods of the Explaintexts class @{@%
function explain_texts(){
  \$texts="";
  if(\$this->wordsstored<=0) return "<h1>niks-schrijven</h1>";
  for(\$i=1; \$i<=\$this->wordsstored; \$i++){
    if(\$this->wordcount[\$i]>0){
      \$texts=\$texts."<span id=\"".\$this->words[\$i]."\">".
              \$this->explanations[\$i].
              "</span>\n";
    };
  };
  return \$texts;
}

@| explain_texts @}

@d methods of the Explaintexts class @{@%
function onmouseoverriedel(){
  return "onmouseover=\"Tip('".\$this->getexplanation()."')\"";
}

@| onmouseoverriedel @}

Extend in a string legalese words for which a help-text is available
with a tag that invokes a tooltip with the explanation. 

@d methods of the Explaintexts class  @{@%
function wordtotooltip(\$instr){
  \$this->reset();
  \$i=1;
  while(\$this->getnextword()!=""){
   \$legawoord=\$this->getcurrentword();
   @< make a pattern to find the legalese words @>
   @< make a replacement for the legalese words @>
   @< replace legalese word by reference tag @>
  };
  return \$instr;
}

@| wordtotooltip @}


The legalese words may appear lowercased, capitalized (first word in a
sentence) or in other forms. The \verb|wordtotooltip| function will
find lowercased, capitalised and uppercased forms and typesets them
identically in the reference tag.

The \php{} function \verb|preg_replace| accepts an array of patterns to
match and an array of replacement strings.
legalese words by \textsc{html} tags that invoke tooltips. The aim is,
to find and replace words in lowercase form, capitalised form and
uppercased form.

@d make a pattern to find the legalese words @{@%
   \$pattern=array(
          0 => "/".strtolower(\$legawoord)."/",
          1 => "/".ucfirst(\$legawoord)."/",
          2 => "/".strtoupper(\$legawoord)."/"
   );
@| \$pattern @}

Legalese words are replaced by \verb|<a>| tags that typeset the word
itself and add an invocation of the \verb|Tip| Javascript
function. (In a former version we appied the \verb|TagToTip| form that
has the advantage that for multiple instances of a legalese word, the
explaining text needs only once to be communicated to the
client. However, direct inclusion of the text into the tag is
simpler).

The string \verb|\$replastring| is a template of the replacement
string, in which the word to be typeset is replaced by the placeholder
(\verb|aapnootMies|). The array \verb|\$replacement| is filled with three
versions of \verb|\$replastring|, in which the replacement is replaced
with respectively the lowercased, the capitalised and the uppercased
form of the legalese word.

@d make a replacement for the legalese words  @{@%
\$replastring="<a class=nepa ";
\$replastring=\$replastring.\$this->onmouseoverriedel();
\$replastring=\$replastring.">";
\$replastring=\$replastring."aapnootMies";
\$replastring=\$replastring."</a>";
\$replacement = array(
  0 => preg_replace("/aapnootMies/", \$legawoord, \$replastring),
  1 => preg_replace("/aapnootMies/", ucfirst(\$legawoord), \$replastring),
  2 => preg_replace("/aapnootMies/", strtoupper(\$legawoord), \$replastring),
);
@| @}


Invoke the \verb|preg_replace| function and count the number of
replacements made.

@d replace legalese word by reference tag @{@%
ksort($pattern);
ksort($replacement);
\$instr=preg_replace(\$pattern, \$replacement, \$instr, -1, \$replcount);
@%\$explaintext->report_times_found(\$replcount);
@| @}

@%Add the explaining texts to the text of the verdict. If a legal word
@%has been used somewhere, its \verb|\$legalcount| value has a positive
@%value. The following function produces a string with the texts.
@%
@%@%@d functions of index @{@%
@%@%function add_explaintexts(){
@%@%  global \$legalwords, \$legalexplanations, \$legalwordcount;
@%@%  \$texts="";
@%@%  for(\$i=1; \$i<=count(\$legalwords); \$i++){
@%@%    if(\$legalwordcount[\$i]>0){
@%@%      \$texts=\$texts."<span id=\"".\$legalwords[\$i]."\">".
@%@%              \$legalexplanations[i].
@%@%              "</span>\n";
@%@%    };
@%@%  };
@%@%  return \$texts;
@%@%};
@%@%@| add_explaintexts @}
@%
@%
@%Add the explaining texts to a string. For some unknown reason the text
@%is visible on the page. Therefore, wrap it in a \verb|div| tag that
@%makes them invisible.
@%
@%@%@d add legalese explanations to @{@%
@%@%
@%@%@1=@1."<div style=\"display: none;\">".\$explaintext->explain_texts()."</div>";
@%@%@| @}
@%
@%
@%does the following:
@%\begin{itemize}
@%\item It accepts a string \verb|instring| as the first argument, a
@%  word \verb|w| as the second
@%  argument and a string \verb|explanation| as the third argument.
@%\item It returns a string as argument. The returned string has been
@%  derived from \verb|instring|, but instances of the word \verb|w|
@%  have been replaced by references to tooltips.
@%\end{itemize}

@d methods of the Explaintexts class @{@%
function insert_text(\$ptr, \$text){
  @< insert legalese word and explanation in the database @>
  \$this->save();
}

@| insert_text @}


Try to make the word in the argument the current word. If this does
not succeed, the word is a new one. Add it at the end of arrays
\verb|\$words| and  \verb|\$explanations|.

@d insert legalese word and explanation in the database @{@%
\$this->reset();
if(\$this->make_current_word(\$ptr)==""){
  \$this->wordcount++;
  \$this->wordsstored++;
  \$this->wordpointer=\$this->wordsstored;
  \$this->words[\$this->wordpointer]=\$ptr;
};
\$this->explanations[\$this->wordpointer]=\$text;
@| @}


Remove the word in the argument from the database if it is present.
@d methods of the Explaintexts class @{@%
function remove(\$ptr){
  if(\$this->make_current_word(\$ptr)!=""){
    unset(\$this->words[\$this->wordpointer]);
    unset(\$this->explanations[\$this->wordpointer]);
    ksort(\$this->words);
    ksort(\$this->explanations);
    \$this->wordsstored--;
    \$this->reset();
    \$this->save();
  };

}
@| remove @}

\section{Help button}
\label{sec:helpbutton}

To help understand how the program works, there is a phony \qstring{help
button} that pops up general information and there are pup-up windows
associated with elements (e.g.{} headers) of the displayed page. The
texts to be displayed are sored in files in directory  \url{m4_helpdir}.

@d create directories @{@%
mkdir -p m4_helpdir
@| @}


@d functions of index @{@%
function helpbutton(){
  @< select the correct helptext for index @>
  @< print the help button @>
}

@| @}

@d functions of backdoordir/index @{@%
function helpbutton(){
  @< select the correct helptext for backdoordir/index @>
  @< print the help button @>
}

@| @}

@d select the correct helptext for index @{@%
if(parameter_value_of('m4_modekeyword')=="c"){
  \$helptextfil="m4_helpdir/conceptmodehelp";
} else {
  if(parameter_value_of('m4_modekeyword')=="d"){
    \$helptextfil="m4_helpdir/documentmodehelp";
  } else { 
    \$helptextfil="m4_helpdir/generalhelp";
  };
};
@| @}

@d select the correct helptext for backdoordir/index @{@%
if(parameter_value_of('m4_modekeyword')=="c"){
  \$helptextfil="m4_helpdir/concepthelphelp";
} else {
  if(parameter_value_of('m4_modekeyword')=="l"){
    \$helptextfil="m4_helpdir/legalesehelphelp";
  } else { 
    \$helptextfil="m4_helpdir/helphelp";
  };
};
@| @}

@d print the help button @{@%
if(file_exists(\$helptextfil)){
  \$general_helptext=preprocessed_tooltiptext(file_get_contents(\$helptextfil));
@%   \$general_helptext=preg_replace("/\n/", " ", \$general_helptext);
} else {
   \$general_helptext="Help tekst is nu niet beschikbaar";
};
tooltipped("Help", \$general_helptext);
@| @}

Here follows the general help information.

@o m4_helpdir/generalhelp @{@%
@%<h1>Help voor eerste pagina</h1>@%
<p> Dit is een test versie, bedoeld om de mogelijkheden
    en moeilijkheden van deze vorm van ondersteuning te
    onderzoeken. Kies de concept-geori&euml;nteerde presentatie of
    kies een van de casus voor de document-geori&euml;nteerde presentatie.
</p>
<p>
  Klik op &quot;Opnieuw&quot; om een andere modus te proberen.
</p>
@| @}

The help-text for concept-oriented mode:

@o m4_helpdir/conceptmodehelp @{@%
<h1>Concept-geori&euml;nteerde modus</h1>
<p>
Het juridische probleem van de gebruiker is ontleed in een aantal
aspecten/concepten. De gebruiker kan een van deze aspecten aanklikken
in het linker-paneel om er uitleg over te krijgen in het
rechterpaneel. Onder de uitleg staan een aantal vonnissen. Als de
gebruiker daar een van aanklikt, dan wordt dit vonnis afgedrukt met
annotaties met betrekking tot het geselecteerde aspect.
</p>
@| @}

The help-text for document-oriented mode:

@o m4_helpdir/documentmodehelp @{@%
<h1>Document-geori&euml;nteerde modus</h1>
<p>
  De computer heeft bij
  het juridische probleem van de gebruiker een aantal vonnissen
  geselecteerd die over vergelijkbare problemen gaan. De gebruiker
  kan een van deze vonnissen aanklikken in het linker-paneel om
  het te lezen in het rechterpaneel. Als zij dat doet, dan verschint
  er in het linkerpaneel een lijst aspecten/concepten die voor het
  probleem relevant zijn, en die ook in het geselecteerde vonnis
  relevant zijn. De gebruiker kan maximaal 3 van deze aspecten
  selecteren. Daarna wordt het afgebeelde vonnis geannoteerd met deze
  aspecten.
</p> 
@| @}


@o m4_helpdir/helphelp @{@%
<h1>Hulpteksten redigeren</h1>
<p>In het programma worden concepten en juridische woorden
uitgelegd. Met deze pagina kunt u de teksten waarmee dat gebeurt
aanpassen of nieuwe teksten toevoegen.</p>
@| @}

@o m4_helpdir/concepthelphelp @{@%
<h1>Uitleg over concepten</h1>
<p>
Selecteer een van de concepten. U kunt daarna de helptekst
redigeren. Accepteer deze helptekst door op de <i>Submit</i> knop te
drukken. 
</p>
@| @}

@o m4_helpdir/legalesehelphelp @{@%
<h1>Uitleg van juridische termen</h1>
<p>
Dit programma biedt de mogelijkheid om uitleg te geven bij woorden in
uitspraken door midden van een op-up venster met verklarende
tekst. Met deze pagina kunt u de verklarende teksten
redigeren. Selecteer een woord waarvoor al een verklarende tekst bestaat
of geef aan dat u een nieuw woord wil invoeren. Vervolgens kunt u een
bestaande tekst redigeren, tekst voor een nieuw woord redigeren of de
verklaring voor een woord schrappen.
</p>
@| @}

@%\chapter{Pattern matching}
@%\label{chap:pattern}
@%
@%Find out whether patterns formed from phrases in search-documents
@%match parts of the text in paragraphs.
@%
@%To handle a matching string, its properties
@%will be stored in an object of class \verb|Matchingstring|. This
@%object stores the following properties:
@%\begin{enumerate}
@%\item The offset of its first character in the text.
@%\item Its number of characters.
@%\item The number of words that it contains.
@%\item The number of the concept to which the fingerprint belongs.
@%\item The weight of the fingerprint to which the string matches.
@%\end{enumerate}
@%
@%@d php functions @{@%
@%class Matchingstring {
@% var \$offs;
@% var \$len;
@% var \$cn;
@% var \$wt;
@% var \$nrwords;
@% @< methods of the Matchingstring class @>
@%}
@%@| Matchingstring @}
@%
@%Objects of this class are constructed while reading the concept table
@%(see \autoref{sec:concepttable}), using the following constructor:
@%
@%
@%@d methods of the Matchingstring class @{@%
@%  function Matchingstring( \$of, \$ln, \$connum, \$wet, \$wot){
@%    \$this->offs=\$of;
@%    \$this->len=\$ln;
@%    \$this->cn=\$connum;
@%    \$this->wt=\$wet;
@%    \$this->nrwords=\$wot;
@%  }
@%@| @}
@%
@%Retrieve the stored parameters with the following methods:
@%\begin{description}
@%\item[offset:] 
@%\item[length:]
@%\item[connum:] Concept number.
@%\item[wc:] Number of words.
@%\item[weight:] 
@%\end{description}
@%
@%@d methods of the Matchingstring class @{@%
@%function connum(){
@%  return \$this->cn;
@%}
@%
@%function wc(){
@%  return \$this->nrwords;
@%}
@%
@%function offset(){
@%  return \$this->offs;
@%}
@%
@%function length(){
@%  return \$this->len;
@%}
@%
@%function weight(){
@%  return \$this->wt;
@%}
@%
@%@| @}
@%
@%
@%Furthermore, method \verb|matches_par| determines whether the offset of
@%the begin of the string lies within a certain range.
@%
@%Check whether the matching string is contained in the current paragraph.
@%@d methods of the Matchingstring class @{@%
@%function matches_par(\$paroff, \$parlen){
@%  return (is_in_range(\$paroff, \$this->offs, \$paroff+\$parlen));
@%}
@%@| @}

\chapter{Print the annotated verdict}
\label{chap:printannotated}

Insert the text of a selected verdict, annotated according to a
selected concept. In fact, this function does not actually print or
display, but it produces a single string with the \textsc{html} coded
text (\verb|\$uittext|) and returns this as function result. The
following function does not write directly, but produces a text string
with the text. The string is further processed by a function that is
embedded into Ajax (cf. section~\autoref{sec:wrapinajax}.

@%To do this, we need to know things about the
@%locations of paragraphs, sentences and about phrases in the text that
@%are related to the concepts. These things are stored in an
@%\emph{offset table} (in a separate file) and in a \emph{concept
@%  file}. With this information we can calculate which parts of the
@%text should be highlighted and in what way they should be highlighted.
@%
@%We use the pseudo-database structure \verb|rnldb|. In it, the texts
@%are located in \verb|m4_uitspraaktextdir|, the offset tables (for
@%paragraphs, sentences and words) in \verb|m4_uitspraakstabdir| and the
@%offsets of fingerprint phrases in \verb|m4_uitspraakconcdir|. Return
@%the \textsc{html} text to be displayed as a single string. If the boolean
@%argument \verb|\$entire| is equal to \verb|TRUE|, print the entire
@%document. Otherwise, print only the relevant parts.

@%\label{scr:printannotatedverdict}
@%@d functions of index  @{@%
@%function printannotatedverdict(\$filename, \$entire){
@%  global \$conceptset;
@%@%  \$conceptset=new Conceptset;
@%@%  \$uittext="";
@%  \$uittext="Hier gaat vonnis ".\$filename." worden afgedrukt.";
@%@%  @< variables of printannotatedverdict @>
@%@%@%  @< initialize the print function @>
@%@%  if(\$conceptset->active_concept_count>0){
@%@%    @< load the offset table @>
@%@%    @< load the concept offsets @>
@%@%  };
@%@%  @< read the text of the verdict @>
@%@%  @< annotate and print the paragraphs @>
@%@%  @< add legalese explanations to @(\$uittext@) @>
@%  return \$uittext;
@%};
@%@| printannotatedverdict \$entire @}

\label{scr:printannotatedverdict}
@d functions of index  @{@%
function printannotatedverdict(\$filename, \$entire){
  global \$conceptset;
  @< variables of printannotatedverdict @>
  \$uittext="";
  if(\$conceptset->active_concept_count>0){
    \$conc=\$conceptset->active_concept(0);
@%    if(\$entire){
@%      \$uittext=\$uittext."Gehele uitspraak.<br>\n";
@%    } else {
@%      \$uittext=\$uittext."Alleen relevante paragrafen  mbt concept \"".\$conc->title()."\".<br>\n";
@%@%      \$uittext=\$uittext."Aantal concepten: ".count(\$conceptset->concepts).".<br>";
@%    };
  };
  \$uittext=\$uittext.display_textsegment(\$filename, "I", \$entire);
  \$uittext=\$uittext.display_textsegment(\$filename, "U", \$entire);
  \$uittext=\$uittext.display_textsegment(\$filename, "C", \$entire);
  @< add legalese explanations to @(\$uittext@) @>
  return \$uittext;
};
@| printannotatedverdict \$entire @}


Print a text-segment (``Indicatie'', ``Uitspraak'' or ``Conclusie'')
of the verdict. Most of the word is performed by an object of the
class \texttt{Seqtoks} (cf.~\autoref{sec:gettext}). The following
function does not really print, but it returns a string with the text
to be printed. It performs the following:
\begin{enumerate}
\item Load the tokens of the text-segment in an object.
\item Check whether there are enough token to justify printing.
\item Generate a string with a header with the segment name.
\item Append the annotated text to the string.
\end{enumerate}

@d functions of index @{@%
function display_textsegment(\$filnam, \$seg, \$entire){
  global \$conceptset;
  global \$rmp;
  \$tokob=new Seqtoks(\$filnam, \$seg);
  if(\$tokob->parcount()<=1) return "";
@%  \$uits=\$tokob->rmes();
  @< print the title of the header segment @>
  @< print the text section @>
  return \$uits;
}

@| display_textsegment @}

@d print the title of the header segment @{@%
if(\$seg=="I"){
  \$seqn="Indicatie";
} else {
  if(\$seg=="U"){
    \$seqn="Uitspraak";
  } else {
    \$seqn="Conclusie";
  }
};
\$uits=\$uits."<h2>".\$seqn."</h2>\n";
@%  \$uits=\$uits."<p>Aantal matches: ".
@| @}

Print the paragraphs. Note, that if annotation is disabled because there are no active concepts, the entire document must be printed, i.e.{} \verb|\$entire| is set to \texttt{TRUE}.
@d print the text section @{@%
@%if(\$seg=="U") \$uits=\$uits.test_annotation(\$filnam,\$tokob);
\$annotate=(\$conceptset->active_concept_count>0);
\$entire=(\$entire || !(\$annotate));
if(\$annotate){
  \$conc=\$conceptset->first_active_concept();
  \$aconcnum=0;
  while(!\$conc===FALSE){
    \$aconcnum++;
    \$tokob->match_phrases_of(\$conc, \$aconcnum);
    \$conc=\$conceptset->next_active_concept();
  };
@%  \$tokob->init_stringannotation();
  \$tokob->find_matchpoints();
@%  \$uits=\$uits.\$tokob->report_matchpoints();
};
\$tokob->initprint();
@%\$uits=\$tokob->rmes();
while(\$tokob->still_paragraphs_to_print()){
  if(\$annotate){
    \$rel_ar=\$tokob->relevances_of_current_paragraph();
@%    \$uits=\$uits.\$tokob->rmes();
    \$is_relevant=(\$rel_ar[1] || \$rel_ar[2] || \$rel_ar[3]);
@%    if(\$is_relevant){
@%      \$uits=\$uits."<p>The following paragraph is relevant for: ";
@%      for(\$i=1;\$i<=3;\$i++){
@%        if(\$rel_ar[\$i]) \$uits=\$uits." ".\$i;
@%      };
@%      \$uits=\$uits.".</p>";
@%    };
  };
  if(\$entire || \$is_relevant) \$uits=\$uits."<p>";
  if(\$is_relevant) \$uits=\$uits."\n<span class=\"".generate_spanlabelname(\$rel_ar)."\">\n";
  \$uits=\$uits.\$tokob->next_paragraphtext(\$entire, \$is_relevant, \$annotate);
  if(\$is_relevant) \$uits=\$uits."\n</span><br>\n";
  @< final paragraph annotations @>
@%  \$uits=\$uits."<p>".\$tokob->rmes()."</p>";
};  
@| @}


Generate a label for the span class of the paragraph, dependent for which concepts it is relevant.

@d functions of index @{@%
function generate_spanlabelname(\$rel_ar){
  \$uits="p";
  for(\$i=1;\$i<=m4_maxactiveconcepts;\$i++){
    if(\$rel_ar[\$i]) \$uits=\$uits.telwoordvan(\$i);
  };
  return \$uits;
}
@| generate_spanlabelname @}


@%Print whether the paragraph is relevant.
@%
@%@d initial paragraph annotations @{@%
@%\$rel_ar=\$tokob->relevances_of_current_paragraph();
@%\$uits=\$uits.\$tokob->rmes();
@%if(\$entire || \$is_relevant) \$uits=\$uits."<p>";
@%if(\$rel_ar[1]) \$uits=\$uits."<p>The following paragraph is relevant</p>";
@%if(\$is_relevant){
@%  \$uits=\$uits."\n<span class=\"".\$spanlabelname."\">\n";
@%};
@%@| @}

@d final paragraph annotations @{@%
if(\$rel_ar[1]){
  @< print end-of-paragraph annotation @>
};
if(\$is_relevant) \$uits=\$uits."</p>\n";
@| @}


\section{Manipulate the text from the database}
\label{sec:gettext}

Obtain the texts from the database. To do this, we need the \texttt{rmp} library.
@d initial php statements @{@%
require_once("m4_rmplib");
\$rmp=new Rmp();
global \$rmp;
@| @}

Store the tokens of a text-segment of a document in an object. Class
\texttt{Seqtoks} stores the tokens and perform required tasks with them.

@d functions of index @{@%
class Seqtoks{
@%global \$rmp;
@< message system for class @>
@< variables of the Seqtoks class @>
@< methods of the Seqtoks class @>
} // End of Seqtoks class
@| Seqtoks @}


Three arrays for the tokens, the sentences and the paragraphs.

@d variables of the Seqtoks class @{@%
var \$tokenlist; // Note: first token is nr. 1.
var \$nrtokens;
var \$sentencelist;
var \$paragraphlist;
var \$ljn;
var \$seg;
@| tokenlist sentencelist paragraphlist@}


The tokenlist is an array with two subscripts. The second index is the
sequence number. The first index has the following value:

\begin{tabular}{ll}
  \texttt{offset} & Offset of the token.               \\
  \texttt{class}  & Token class.                       \\
  \texttt{casus}  & Case (if the token is a word).     \\
  \texttt{text}   & The word (if the token is a word). \\
  \texttt{stem}   & The word-stem. \\
\end{tabular}


\subsection{Get the tokens from the database}
\label{sec:gettokens}


Load the tokens during construction of the object. Load the list with
sentences and paragraphs as well.

@d methods of the Seqtoks class @{@%
function __construct(\$did, \$textseg){
  global \$rmp;
  \$this->ljn=\$did;
  \$this->seg=\$textseg;
  \$this->tokenlist=\$rmp->tokenlist_of(\$this->ljn, \$this->seg);
  \$this->nrtokens=count(\$this->tokenlist["offset"]);
  \$this->sentencelist=\$rmp->sentencelist_of(\$this->ljn, \$this->seg);
  \$this->paragraphlist=\$rmp->paragraphlist_of(\$this->ljn, \$this->seg);
  @< construct Seqtoks @>
}
@| @}

\subsection{Print a paragraph}
\label{sec:printpar}

Paragraphs will be printed in the natural order. To minimise problems
with indexes, use a function that processes at each call the next
paragraph and a function that resets to start again. The functions
return "false" if there is nothing to print.

Since the \verb|paragraphlist| is a multi-dimensional array, we cannot
easily use the \texttt{reset} and \texttt{current} array
function. Therefore, use the following variable,
\verb|$parrec|. This variable contains either an array with
pointers to the first and last token or the boolean \texttt{FALSE}.

@d variables of the Seqtoks class @{@%
var \$parrec;
@| \$parrec @}

Variable \texttt{parrec} contains either an array with pointers to the
first/last token of the paragraph or, when every paragraph has been
processed, the boolean \texttt{FALSE}.

@d update parrec @{@%
if(current(\$this->paragraphlist["first"])===FALSE){
  \$this->parrec=FALSE;
} else {
  \$this->parrec=array( "first" => current(\$this->paragraphlist["first"])
                      ,  "last" => current(\$this->paragraphlist["last"])
                      );
};
@| @}


Initially, reset the arrays in \texttt{paragraphlist}.

@d methods of the Seqtoks class @{@%
function initprint(){
  reset(\$this->paragraphlist["first"]);
  reset(\$this->paragraphlist["last"]);
  @< update parrec @>
  return \$this->parrec;
}

@| @}

Report whether there are still paragraphs to print.

@d methods of the Seqtoks class @{@%
function still_paragraphs_to_print(){
  return (\$this->parrec===FALSE ? FALSE : TRUE);
}
@| @}

Process the tokens of a paragraph and update \texttt{parrec} (to point
to next paragraph). Print the entire text if annotation is disabled (otherwise everything would be skipped).

@d methods of the Seqtoks class @{@%
function next_paragraphtext(\$entire, \$is_relevant, \$annotate){
  if(\$entire || \$is_relevant){
    \$bol=TRUE;
@%    \$uits="";
@%      \$uits=\$uits."<p>van ".\$this->parrec["first"]." tm ".\$this->parrec["last"].". Stringstart: ".\$this->next_string_edge.".</p>";
@%    \$this->init_stringannotation();
@%    \$uits=\$uits."<p>".\$this->rmes()."</p>";
    for(\$i=\$this->parrec["first"];\$i<=\$this->parrec["last"];\$i++){
      @< print token nr. i @>
      \$bol=FALSE;
    };
  } else {
    \$uits="...";
  };
@%  \$uits=\$uits.\$this->rmes();
  next(\$this->paragraphlist["first"]);
  next(\$this->paragraphlist["last"]);
  @< update parrec @>
  while(\$this->next_string_edge<\$this->parrec["first"]) \$this->next_matchpoints_element();
  //Test:
@%  if(\$uits=="<p></p>") \$uits="<p>Lege paragraaf</p>";
@%  if(preg_match("/\<p\>[ \n]*\</p>\/",\$uits)>0) \$uits="<p>Lege paragraaf</p>";
  return \$uits;
}
@| @}



Find out in which paragraph a token resides.
@d methods of the Seqtoks class  @{@%
function paroftok(\$toknum){
  \$lastkey="";
  foreach(\$this->paragraphlist as \$key => \$num){
    if(\$toknum>\$num){
      if(\$lastkey==""){
        return \$key;
      } else {
        return \$lastkey;
      };
    };
    \$lastkey=\$key;
  };
}

@| paroftok @}


@d methods of the Seqtoks class @{@%
function testit(){
  global \$rmp;
  \$uits="<p>ID van seg. \"".\$this->seg."\" van ".\$this->ljn.": ";
  \$uits=\$uits.\$rmp->id_of_subtext(\$this->ljn, \$this->seg)."</p>\n";
@%  \$this->tokenlist=\$rmp->tokenlist_of(\$this->ljn, \$this->seg);
  \$uits=\$uits."<p>Aantal tokens: ".count(\$this->tokenlist);
@%  if(count(\$this->tokenlist)>=4){
@%    \$this->sentencelist=\$rmp->sentencelist_of(\$this->ljn, \$this->seq);
@%    \$uits=\$uits."<p>Grootte sentencelist: ".count(\$this->sentencelist);
@%  };
  return \$uits;
}
@| @}


Return a string with the tokens of paragraph \texttt{n}. First find
out how many paragraphs there are.

@d methods of the Seqtoks class  @{@%
function parcount(){
  return count(\$this->paragraphlist["first"]);
}
@| @}

@%Concatenate the tokens into a string. Prepend the word tokens, except
@%the first word, with a space. Variable \verb|\$bol| signifies
@%\emph{begin of line}. The first index of the three-dimensional array
@%\verb|\$tokenlist| is one of the following words:
@%\begin{tabular}{ll}
@%\texttt{offset} & offset of the token. \\
@%\texttt{class}  & class of the token. \\
@%\texttt{casus}  & capitalization. \\
@%\texttt{text}   & the text if it is a word token. \\
@%\texttt{stem}   & the text if it is a word token.
@%\end{tabular}
@%
@%@d methods of the Seqtoks class  @{@%
@%function paragraphtext(\$num){
@%  \$bol=TRUE;
@%  \$uits="";
@%  for(\$i=\$this->paragraphlist["first"][\$num];\$i<=\$this->paragraphlist["last"][\$num];\$i++){
@%    @< print token nr. i @>
@%    \$bol=FALSE;
@%  };
@%  return \$uits;
@%}
@%
@%@| @}

Print the token. Print a space before a word-token,
unless the token is the first word of a line. Append an annotation to
the token if it is the first or last token of a matching string.

@d print token nr. i @{@%
if(\$this->tokenlist["text"][\$i]){
  if(!\$bol) \$uits=\$uits." ";
@%  \$uits=\$uits.token_word( \$this->tokenlist["casus"][\$i]
@%                          , \$this->tokenlist["text"][\$i]
@%                          , \$this->tokenlist["class"][\$i]
@%                          );
  \$tokenstr=token_word( \$this->tokenlist["casus"][\$i]
                          , \$this->tokenlist["text"][\$i]
                          , \$this->tokenlist["class"][\$i]
                          );
} else {
  \$tokenstr=\$this->tokenlist["class"][\$i];
@%  \$uits=\$uits.\$this->tokenlist["class"][\$i];
};
\$uits=\$uits.( \$annotate
              ? \$this->annotate_token(\$tokenstr,\$i)
              : \$tokenstr
              );
@| @}

Function \verb|token_word| returns the text of a word-token in proper
capitalisation.

@d functions of index @{@%
function token_word(\$casus, \$text, \$class){
  if(!\$text) return \$class; 
  switch(\$casus){
   case "U":
     \$retval=strtoupper(\$text);
     break;
   case "C":
     \$retval=ucfirst(\$text);
     break;
   default:
     \$retval=\$text;
  };
  return \$retval;
}

@| token_word @}

\section{Find strings that match phrases from the search documents}
\label{sec:findphrases}

Generate a table with information about the phrases in the document
that match phrases in the search-document. The following information
is needed:
\begin{enumerate}
\item The number of paragraph that contains the matching phrase;
\item The number of the first token of the matching phrase;
\item The number of the last token of the matching phrase;
\item The number of the active concept to which the search document belongs;
\item The number of the phrase in the search document;
\item Whether the matching phrase is a single word;
\item The weight of the phrase in the search document.
\end{enumerate}

Use the following code to register a match. Arguments:
\begin{enumerate}
\item Pointer to the first matching token in the tokenlist.
\item Pointer to the last matching token in the tokenlist.
\item Active concept number.
\item Number of the phrase.
\item Weight of the phrase.
\end{enumerate}

@d register match @{@%
      \$this->nrmatches++;
      \$this->matches["parnum"][\$this->nrmatches]=\$this->paroftok(@1);
      \$this->matches["firsttok"][\$this->nrmatches]=@1;
      \$this->matches["lasttok"][\$this->nrmatches]=@2;
      \$this->matches["cn"][\$this->nrmatches]=@3;
      \$this->matches["pn"][\$this->nrmatches]=@4;
      \$this->matches["wt"][\$this->nrmatches]=@5;
@| @}


Note that we must match the stems of the words, not the words
themselves. 

@d variables of the Seqtoks class @{@%
var \$matches;
var \$nrmatches;
@| \$matches @}

@d construct Seqtoks  @{@%
\$this->matches=FALSE;
\$this->nrmatches=0;
@| @}


We must match the stems of the words, not the words itself.

Method \verb|find_matches| matches the text with the search-document
of the concept in the first argument. The second argument is the
number of the active concept.

@d methods of the Seqtoks class  @{@%
function match_phrases_of(\$conc, \$num){
  \$phrases=\$conc->fingerphrases();
  \$weights=\$conc->fingerweights();
  foreach(\$phrases as \$key => \$phrase){
    \$this->match_string(\$phrase, \$weights[\$key], \$key, \$num);
  };
}

@| match_phrases_of @}


@d methods of the Seqtoks class @{@%
function match_string(\$phrase, \$weight, \$pnum, \$cnum){
  global \$rmp;
  if(\$phrase===FALSE) return;
  \$sphrases=\$rmp->get_stemmed_words(preg_split("/ +/", \$phrase));
  \$tptr=1;
  while(\$tptr+count(\$sphrases)<\$this->nrtokens){
    \$wd=reset(\$sphrases);
    \$ttptr=\$tptr;
    while(TRUE){
      \$partmatch=(\$wd==\$this->tokenlist["stem"][\$ttptr]);
      if(!\$partmatch) break;
      \$wd=next(\$sphrases);
      if(\$wd===FALSE) break;
      \$ttptr++;
    };
    if(\$partmatch){
      @< register match @(\$tptr@,\$ttptr@,\$cnum@,\$pnum@,\$weight@) @>
    };
    \$tptr++;
  };
}

@| @}




Test pattern matching.

@d methods of the Seqtoks class @{@%
function matchreport(){
  \$uits="<p>Number of matches: ".\$this->nrmatches."</p>";
  if(\$this->nrmatches>0){
    \$uits=\$uits."<p>";
    for(\$i=\$this->matches["firsttok"][1];\$i<=\$this->matches["lasttok"][1];\$i++){
      \$uits=\$uits." ".\$this->tokenlist["text"][\$i];
    };
    \$uits=\$uits."</p>";
  };
  return \$uits;
}

@| @}

\section{Find out whether the paragraph is relevant}
\label{sec:par-relevance}

A paragraph is considered to be relevant wrt a concept if enough parts of it match
strings of the search-document of the concept. Find out whether the
current paragraph is relevant. To determine this for a concept, add up the weights
of the matching fingerprint strings. The following function produces
a boolean array in which the relevance for the active concepts is reported.

@d methods of the Seqtoks class @{@%
function relevances_of_current_paragraph(){
  \$weights[1]=0;\$weights[2]=0;\$weights[3]=0;
  for(\$i=1;\$i<=\$this->nrmatches;\$i++){
    if(     \$this->matches["firsttok"][\$i]>=\$this->parrec["first"]
        &&  \$this->matches["firsttok"][\$i]<=\$this->parrec["last"]
      ){
     \$weights[\$this->matches["cn"][\$i]]+=\$this->matches["wt"][\$i];
@%     \$this->ames("<p>Add ".\$this->matches["wt"][\$i]." to weights[".\$this->matches["cn"][\$i]."].</p>");
    };
  };
@%  // Test:
@%  \$this->ames("<p>Weights:");
@%  \$w=reset(\$weights);
@%  while(!(\$w===FALSE)){
@%    \$this->ames(" (".key(\$weights).",".\$w.")");
@%    \$w=next(\$weights);
@%  };
@%  \$this->ames("</p>");
  \$weightsum=array_sum(\$weights);
  \$tr=0;
  for(\$i=0;\$i<m4_maxactiveconcepts;\$i++){
    \$rel[\$i]=(\$weights[\$i] > m4_singleweighttresh);
    if(\$rel[\$i])\$tr++;
  };
  if(\$tr>0){
    \$tr=0;
    for(\$i=0;\$i<m4_maxactiveconcepts;\$i++){
      \$rel[\$i]=(\$weights[\$i] > m4_multiweighttresh);
      if(\$rel[\$i])\$tr++;
    };
  };
  return \$rel;
}

@| relevances_of_current_paragraph @}

@%@d functions of index @{@%
@%function test_annotation(\$filnam,\$tokob){
@%  global \$conceptset;
@%  global \$rmp;
@%  \$tokob->match_phrases_of(\$conceptset->active_concept(0), 0);
@%  return \$tokob->matchreport();
@%}
@%
@%@| @}

\section{Generate tags to annotate matching strings}
\label{sec:annotations}

Find the numbers of the tokens where matching strings begin and end
and associate \HTML{} tags to these points. The phrases are wrapped in
span tags, of which the class names are composed by the letter ``f''
followed by the numbers of the active concepts in letters. For
example, a phrase that is relevant for concepts two and three is
surrounded by a \verb|<span class="fonetwo">| and a \verb|</span>| tag.

To annotate the phrases in this way, we generate an array that
contains for every point where a relevant phrase begins or ends the
number of the token and an array with an entry for each of the active
concepts. This entry is \verb|+n| if the token is the first one of $n$
relevant phrases for that concept and \verb|-n| if it is the last
token of such phrase. If the token is only a single-word phrase it is
assigned an asterix (\verb|*|).


@d variables of the Seqtoks class @{@%
  var \$matchpoints=array();
@| \$matchpoints  @}

@%The method \verb|find_matchpoints| fills the array
@%\verb|\$matchpoints| during construction of the Seqtoks object.

@%@d construct Seqtoks @{@%
@%  \$this->find_matchpoints();
@%@| @}

Collect the tokens where relevant phrases begin or end. Array
\verb|\$tagset| keeps record of the concepts that are relevant.

@d methods of the Seqtoks class @{@%
function find_matchpoints(){
  unset(\$this->matchpoints);
  \$this->matchpoints=array();
  \$found=0;
  for(\$i=1;\$i<=\$this->nrmatches;\$i++){
    \$found++;
    @< write the findings in the matchpoint array @>
  };
  ksort(\$this->matchpoints);
  \$this->reset_matchpoints_array();
}
@| find_matchpoints @}


Increment the element of matchpoint of which the index is equal to the
number of the first token of the matching string unless this element
contains an asterix (\verb|*|). In that case, replace the asterix by
the number~1. Perform analogously for the end of the matching
string. If the matching string consists of a single word, assign an
asterix to the corresponding element in matchpoint unless the element
contains a number. 

@d write the findings in the matchpoint array @{@%
\$ft=\$this->matches["firsttok"][\$i];      
\$lt=\$this->matches["lasttok"][\$i];
\$cn=\$this->matches["cn"][\$i];
if(\$ft==\$lt){
  @< matchpoint values for single-word string @>
} else {
  @< matchpoint values for first word of string @>
  @< matchpoint values for last word of string @>
};
@| @}


@d matchpoint values for single-word string @{@%
if(\$this->matchpoints[\$ft][\$cn]==""){
  \$this->matchpoints[\$ft][\$cn]="*";
};
@| @}

@d matchpoint values for first word of string @{@%
switch(\$this->matchpoints[\$ft][\$cn]){
  case "":
  case "*":
    \$this->matchpoints[\$ft][\$cn]=1;
    break;
  default:
    \$this->matchpoints[\$ft][\$cn]++;
};
@| @}

@d matchpoint values for last word of string @{@%
switch(\$this->matchpoints[\$lt][\$cn]){
  case "":
  case "*":
    \$this->matchpoints[\$lt][\$cn]=-1;
    break;
  default:
    \$this->matchpoints[\$lt][\$cn]--;
};
@| @}




If strings of the same concepts overlap, the annotation does not work. Therefore, make sure that a start-tag is followed by a stop-tag, and a stop-tag is followed by a start-tag.

@d check integrity of the matchpoints @{@%
\$this->reset_matchpoints_array();
for(\$i=1;\$i<=m4_maxactiveconcepts;\$i++){
   \$lastplus[\$i]=-1;
   \$lastminus[\$i]=-1;
   \$stat[\$i]=0;
};
foreach(\$this->matchpoints as \$key => \$mpar){
  for(\$i=1;\$i<=m4_maxactiveconcepts;\$i++){
    if((\$mpar[\$i]=="*") && \$stat==1){
      \$matchpoints[\$key][\$i]="";
    } else {
      if((\$mpar[\$i]=="+")){
        if(\$stat[\$i]==0){
          \$stat[\$i]=1; \$lastplus[\$i]=\$key; \$lastminus[\$i]=-1;
        } else {
         \$matchpoints[\$key][\$i]="";
        };
      } else {
        if(\$mpar[\$i]=="-"){
          if(\$stat==0){
            \$matchpoints[\$lastminus[\$i]]="";
            \$lastminus[\$i]=\$key;
          } else {
            \$stat[\$i]=0; \$lastminus[\$i]=\$key;\$lastminus[\$i]=-1;
          };
        };
      };
   }
  }
};

@| @}




Print the matchpoints as a test:

@d methods of the Seqtoks class @{@%
function report_matchpoints(){
  \$uits="<table>";
  foreach(\$this->matchpoints as \$toknum => \$value){
    \$uits=\$uits."<tr><td>".\$toknum."</td><td>".\$this->tokenlist["text"][\$toknum]."</td>";
    for(\$i=1;\$i<=3;\$i++){
       \$uits=\$uits."<td>".((\$value[\$i]=="") ? "." : \$value[\$i])."</td>";
    }
    \$uits=\$uits."</tr>\n";
  };
  \$uits=\$uits."</table>";
  reset(\$this->matchpoints);
  return \$uits;
}
@| @}





Rewind the matchpoints array before printing a text:

@d methods of the Seqtoks class @{@%
function reset_matchpoints_array(){
  if(reset(\$this->matchpoints)===FALSE){
   \$this->next_string_edge=\$this->nrtokens+1;
  } else {
   \$this->next_string_edge=key(\$this->matchpoints);
  };
  return \$this->next_string_edge;
}

@| reset_matchpoints_array @}


@d methods of the Seqtoks class @{@%
function next_matchpoints_element(){
  if(next(\$this->matchpoints)===FALSE){
   \$this->next_string_edge=\$this->nrtokens+1;
  } else {
   \$this->next_string_edge=key(\$this->matchpoints);
  };
  return \$this->next_string_edge;
}

@| @}



@%@d  @{@%
@%    reset(\$mpt);
@%    for(\$i=1;\$i<=3;\$i++){
@%      \$relcons[\$i]=FALSE;
@%    };
@%    while(!(current(\$mtp)===FALSE)){
@%      \$tokn=key(current(\$mtp));
@%      \$tag="";
@%      for(\$i=1;\$i<=3;\$i++){
@%       if(current(\$mtp)[\$i]=="-"){
@%        \$tag=\$tag."</".\$tags[\$tagtal].">";
@%        \$tagtal--;
@%       };
@%      };
@%      if(!(\$tag=="")) \$this->matchpoints[\$tokn]["endtag"]=\$tag;
@%      \$tag="";
@%      for(\$i=1;\$i<=3;\$i++){
@%       if(current(\$mtp)[\$i]=="+"){
@%        \$tag=\$this->modify_begintag(\$tag,\$relcons,\$i);
@%       };
@%      };
@%      \$this->matchpoints[\$tokn]["begintag"]=\$tag;
@%      next(\$mtp);
@%    };
@%@| @}
@%
@%@d methods of the Seqtoks class @{@%
@%function modify_endtag(\$tag,\$relcons,\$i){
@%  if(\$tag=="){
@%    return "/p".telwoordvan(\$i);
@%}
@%@| @}

Append a span tag to a token if it is the first or the last token of a
matching string. Assume that this function is called for every token
in sequence. Keep record of the concepts of which the current token is
part of a matching string. 

@d variables of the Seqtoks class @{@%
var \$matchconcepts;
var \$stagtal;
var \$next_string_edge = 0;
@| \$matchconcepts \$stagtal  \$next_string_edge @}

@%The following function makes the internal pointer of
@%\verb|\$matchpoints| point to the first element in which the
@%token-number is larger than the number of the first token. The number
@%of the first token in that element is stored in \verb|next_string_edge|.
@%
@%@d methods of the Seqtoks class  @{@%
@%function init_stringannotation(){
@%  \$this->find_matchpoints();
@%  for(\$i=1;\$i<=m4_maxactiveconcepts; \$i++) \$this->matchconcepts=FALSE;
@%  \$this->stagtal=0;
@%  if(reset(\$this->matchpoints)===FALSE){
@%    \$next_string_edge=\$this->parrec["last"]+1;
@%     return;
@%  };
@%  \$this->next_string_edge=key(\$this->matchpoints);
@%  // next_string_edge is a number
@%  while(TRUE){
@%    if(\$this->next_string_edge>=\$this->parrec["first"]) break;
@%    if(next(\$this->matchpoints)===FALSE){
@%      \$next_string_edge=\$this->parrec["last"]+1;
@%      break;
@%    };
@%    \$this->next_string_edge=key(\$this->matchpoints);
@%  };
@%  // next_string_edge > parrec["first"]
@%}
@%
@%@| init_stringannotation @}


To print a token, first find out whether it is on one of the ends of
matching strings. If so, check whether it is at the end of matching
strings and generate end-tags in that case. Then, check whether it is
at the start of phrases and generate begin-tags in that case.

To generate the right tags, remember the concepts for which the
current token is an element of matching strings.

@d variables of the Seqtoks class @{@%
var \$matchstringcount=array( 1 => 0, 2 => 0, 3 => 0);
@| @}

Check whether the current token is on the begin or end of matching
strings or whether is it a single-word matching string. Then, check
for which concept this token is relevant. Generate a
start-tag accordingly. Then check for which concepts it is the last
relevant token and generate an end-tag accordingly.
@d methods of the Seqtoks class @{@%
function annotate_token(\$tk,\$toknum){
    \$tok=\$tk;
@%  if(\$toknum==2653) \$this->ames("<p>Token ".\$toknum."; next_string_edge: ".\$this->next_string_edge."</p>");
  if(\$toknum>=\$this->next_string_edge){
    \$mpar=current(\$this->matchpoints);
    \$beginrelevances=\$this->matchstringcount;
    \$endrelevances=\$this->matchstringcount;
    for(\$i=1;\$i<=3;\$i++){
      for(\$i=1;\$i<=3;\$i++){
        \$val=\$mpar[\$i];
        if(!(\$val=="")){
          if(\$val=="*"){
	    \$beginrelevances[\$i]++;
          } else {
            if(\$val>0){
	      \$beginrelevances[\$i]++;
	      \$endrelevances[\$i]++;
	    } else {
              if(\$val<0){
	        \$endrelevances[\$i]--;
              };
            };
          };
	};
      };
@%      switch(\$mpar[\$i]){
@%        case "": break;
@%        case "*": \$beginrelevances[\$i]++;
@%                  break;
@%        case "+": \$beginrelevances[\$i]++;
@%                  \$endrelevances[\$i]++;
@%                  break;
@%        case "-": \$beginrelevances[\$i]--;
@%                  \$endrelevances[\$i]--;
@%                  break;
@%      };
    };
    @< generate a new tag before the token? @>
    @< generate a new tag after the token? @>
    \$this->matchstringcount=\$endrelevances;
    \$this->next_matchpoints_element();
  };
  return \$tok;
}

@| @}

@%    @< generate single-word tags @>
@%    @< generate end-tags @>
@%    @< generate start-tags @>
@%@%    \$this->ames("<p>generated span tags ".\$tok."</p>");
@%    \$this->next_matchpoints_element();
@%  };

If the contents of \verb|beginrelevances| has become different from
\verb|matchstringcount|, prepend the token with and end-tag and a new
begin-tag. Do a similar thing if \verb|endrelevances| is different
from \verb|endrelevances|.


@d generate a new tag before the token? @{@%
@< check for changes between two relevance arrays @(\$this->matchstringcount@,\$beginrelevances@) @>
if(\$changed){
  @< generate initial tags @>
};
@| @}

@d generate a new tag after the token? @{@%
@< check for changes between two relevance arrays @(\$beginrelevances@,\$endrelevances@) @>
if(\$changed){
  @< generate final tags @>
};
@| @}



@d check for changes between two relevance arrays @{@%
\$changed=FALSE;
foreach(@1 as \$key => \$value){
  if( (@1[\$key]>0)  && (@2[\$key]<=0)
                     ||
      (@1[\$key]<=0) &&  (@2[\$key]>0)
    ){
    \$changed=TRUE;
    break;
  };
};
@| @}



If the token is in the middle of matching strings, it is in the range
of a \verb|span|. Generate in that case a \verb|</span>| tag before
the new tag. Variable \verb|\$inmatch| signals whether the token is in
the middle of a matching string.

@d generate initial tags @{@%
@< check whether token is in the middle of something @(\$this->matchstringcount@) @>
\$tok=(\$inmatch ? "</span>" : "")."<span class=\"".\$this->spanclassof(\$beginrelevances)."\">".\$tok;
@%\$tok=(\$inmatch ? "&lt;/span&gt;" : "")."&lt;span class=\"".\$this->spanclassof(\$beginrelevances)."\"&gt;".\$tok;
@| \$inmatch @}

Similarly, if the token is not in the middle of matching strings but
at the end of some, append a \verb|</span>| tag to it, but do not
generate a new tag.

@d generate final tags @{@%
  @< check whether token in the middle of something @(\$endrelevances@) @>
  \$tok=\$tok."</span>".(\$inmatch ? "<span class=\"".\$this->spanclassof(\$endrelevances)."\">" : "");
@%  \$tok=\$tok."&lt;/span&gt;".(\$inmatch ? "&lt;span class=\"".\$this->spanclassof(\$endrelevances)."\"&gt;" : "");
@|  @}


@d check whether token is in the middle of something @{@%
\$inmatch=FALSE;
foreach(@1 as \$key => \$value){
  if(\$value>0){
    \$inmatch=TRUE;
    break;  
  };
};
@| @}


@d methods of the Seqtoks class  @{@%
function spanclassof(\$relar){
  \$lab="f";
  foreach(\$relar as \$key => \$value){
    if(\$value>0) \$lab=\$lab.telwoordvan(\$key);
  };
  return \$lab;
}
@| @}



Check whether a token matches a single-word string. If so, check
whether it is a sub-string of a larger matching string. If that is not
so, generate tags to label the token.

@d generate single-word tags @{@%
for(\$i=1;\$i<=m4_maxactiveconcepts;\$i++){
  if(\$mpar[\$i]=="*"){
     if(\$matchstringcount[\$i]<=0){
       @< place conditionally an end-tag before the token @>
       \$matchstringcount[\$i]++;
       @< add start-tag to token @>
       \$matchstringcount[\$i]--;
       @< add end-tag to token @>
     };
  };
};
@| @}


@d generate end-tags @{@%
for(\$i=1;\$i<=m4_maxactiveconcepts;\$i++){
  if(\$mpar[\$i]<0){
    for(\$j=\$mpar[\$i];\$j<0; \$j++){
@%      \$this->stagtal--;
      \$tok=\$tok."</span>";
    };
  };
@%    \$this->ames("<p>Token :".\$toknum." (".\$this->tokenlist["text"][\$toknum].") is last token for act. concept ".\$i.".</p>");
@%    if(\$this->stagtal>0){
@%     \$this->matchconcepts[\$i]=FALSE;
@%     \$tok=\$tok."</span>";
@%    };
@%  };
@| @}


@d generate start-tags @{@%
\$lasttagtal=\$this->stagtal;
for(\$i=1;\$i<=m4_maxactiveconcepts;\$i++){
  if(\$mpar[\$i]>0){
    for(\$j=\$mpar[\$i];\$j>0; \$j--){
      @< add start-tag to token @>
@%      \$this->stagtal++;
      \$tok=\$tok."</span>";
    };
@%    \$this->ames("<p>Token :".\$toknum." (".\$this->tokenlist["text"][\$toknum].") is first token for act. concept ".\$i.".</p>");
    \$this->matchconcepts[\$i]=TRUE;
    \$this->stagtal++;
  };
}
if(\$lasttagtal<\$this->stagtal){
@%    \$this->ames("<p>So, generate start tag.</p>");
  @< add start-tag to token @>
};
@| @}


@d add start-tag to token @{@%
\$tagclass="f";
for(\$j=1;\$j<=m4_maxactiveconcepts;\$j++){
  if(\$this->matchconcepts[\$j]) \$tagclass=\$tagclass.telwoordvan(\$j);
};
\$tok="<span class=\"".\$tagclass."\">".\$tok;
@%\$tok="&lt;span class=\"".\$tagclass."\"&gt;".\$tok;
@| @}



@%\subsection{Read the text to be annotated}
@%\label{sec:readit}
@%
@%Read the complete text and put it in a single string. 
@%
@%Note: For some unknown reason, the string function of\textsc{php} does
@%not count \index{UTF8}\textsc{utf8} correctly, which gives rise to
@%offset errors. Therefore, decode the first to iso.
@%
@%@d read the text of the verdict @{@%
@%\$fullfilename="m4_uitspraaktextdir`'/" . \$filename;
@%\$tekst=utf8_decode(file_get_contents(\$fullfilename));
@%@%printf("<p>%s</p>\n", substr(\$tekst, 10, 20));
@%if(\$tekst==FALSE){
@%  printf("<p>Kan de uitspraak niet lezen .. Sorry.</p>\n");
@%  return;
@%}
@%@| @}
@%
@%
@%\subsection{Load offset tables}
@%\label{sec:loadoffsettables}
@%
@%\subsubsection{Word table}
@%\label{sec:wordtable}
@%
@%
@%The offset table contains (should contain) a line that begins with the
@%word \verb|m4_sentencetablabel|, that contains the offset of the
@%sentences, a line with the word \verb|m4_pbtablabel| that contains the
@%offsets of the beginnings of paragraphs and a line with the word
@%\verb|m4_petablabel| that contains the offsets of the lengths of
@%paragraphs.
@%
@%@d load the offset table @{@%
@%\$itemsfound=0;
@%\$offsetfile="m4_uitspraakstabdir/".\$filename;
@%m4`'_rlbl(`\$offsetfile',
@%`read a line of the offset table',
@%`Kan de offset tabel niet lezen. Sorry.')
@%@| @}
@%
@%Read the lines the begin with \verb|m4_sentencetablabel|,
@%\verb|m4_pbtablabel| and \verb|m4_petablabel|. Store the contents in
@%arrays \verb|\$sb|, \verb|\$pb| resp.~\verb|\$pl|.
@%
@%Apparently, we need three items. When we found them, we can stop to
@%read the input file.
@%
@%@d read a line of the offset table @{@%
@%  @< check offsettable item @(m4_sentencetablabel@,sb@) @>
@%  @< check offsettable item @(m4_pbtablabel@,pb@) @>
@%  @< check offsettable item @(m4_petablabel@,pl@) @>
@%  if(\$itemsfound>=3) break;
@%@| \$itemsfound @}
@%
@%If \verb|\$line|  starts with one of the keywords, expand the rest of
@%the line into the associated array. 
@%
@%@d check offsettable item @{@%
@%\$keyw="@1";
@%\$regxp="/^@1/";
@%if(preg_match(\$regxp, \$line)){
@%  \$line=trim(substr(\$line,strlen("@1")));
@%  \$@2=preg_split("/[\s]+/",\$line);
@%  \$itemsfound++;
@%};
@%@| @}
@%
@%
@%\subsubsection{Concept table}
@%\label{sec:concepttable}
@%
@%The concept table contains information about matching strings. Store
@%this information in an array of objects of class Matchingstring.
@%
@%@d load the concept offsets @{@%
@%\$offsetfile="m4_uitspraakconcdir/".\$filename;
@%m4`'_rlbl(`\$offsetfile',
@%`read a line of the concept table',
@%`Kan de concept tabel niet lezen. Sorry.')
@%@| @}
@%
@%
@%The concept table has the following columns:
@%\begin{enumerate}
@%\item the number of the concept;
@%\item the number of the fingerprint string;
@%\item the weight of the fingerprint string;
@%\item the number of words in the fingerprint string;
@%\item (and following columns): the offsets and lengths of the matching
@%  strings.
@%\end{enumerate}
@%
@%@%Store the information into the following arrays:
@%@%
@%@%\begin{description}
@%@%\item[conoff{[}cn{]}{[}fn{]}:] Offsets of the matching strings.
@%@%\item[conlen{[}cn{]}{[}fn{]}:] Lengths of the matching strings.
@%@%\item[conweight{[}cn{]}:] Weight of each fingerprints.
@%@%\item[conwc{[}cn{]}:] Number of words in each fingerprint.
@%@%\end{description}
@%@%
@%
@%Process only the lines that contain fingerprints of \qstring{active}
@%(selected) concepts. Create for those fingerprints
@%\verb|Matchingstring| objects and store these in array
@%\verb|\$matcharr[]|.
@%
@%@d read a line of the concept table @{@%
@%\$ar=preg_split("/[\s]+/", \$line);
@%\$cn=\$ar[0];
@%if(\$conceptset->is_active_concept(\$cn)){
@%  \$fpnum=\$ar[1];
@%  \$weight=\$ar[2];
@%  \$wc=\$ar[3];
@%  for(\$i=4;\$i<count(\$ar);\$i++){
@%    \$ar2=preg_split("/,/", \$ar[\$i]);
@%    \$mat = new Matchingstring(\$ar2[0], \$ar2[1], \$cn, \$weight, \$wc);
@%    \$matcharr[]=\$mat;
@%  };
@%}
@%
@%@|\$conweight \$conwc \$conoff  \$conlen  \$ar \$ar2 @}


@%\subsection{Determine what must be highlighted}
@%\label{sec:whathilit}
@%
@%The following algorithm (from~\cite{wildeboer2007a}) will be used to
@%determine what has to be highlighted in the text:
@%
@%\begin{enumerate}
@%\item The verdict is separated into paragraphs: paragraphs are
@%      separated by enters or even white space.
@%\item Within each paragraph, the number of fingerprint terms found is counted.
@%\item If there are only terms from one fingerprint (thus concept)
@%      in the paragraph (which can visually be noted by the presence of
@%      only one color):
@%  \begin{enumerate}
@%    \item If there are more than two terms present, the paragraph
@%          is deemed relevant for that concept.
@%    \item If one or two terms, but consisting of more than a
@%          single word, the paragraph is deemed relevant for that concept.
@%    \item If two terms of only one word, but differing, the paragraph
@%          is deemed relevant for that concept.
@%    \item If only one term of one word, the paragraph isn't deemed
@%          relevant for that concept.
@%  \end{enumerate}
@%\item If more than one concept is described by its fingerprint
@%      terms in the paragraph (more than one color visible):
@%  \begin{enumerate}
@%    \item Above rules are applicable for every concept, but
@%          if a concept is only described by one term, of
@%          one word, but is in the same sentence as a
@%          term from the other concept, the paragraph is
@%          deemed relevant for that concept as well (a
@%          sentence is defined as the string from the last
@%          uppercase letter following a period, until the next
@%          period followed by an uppercase letter)
@%  \end{enumerate}
@%\end{enumerate}
@%
@%
@%@d calculate the places to be highlighted @{@%
@%if(\$conceptnum==""){
@%}
@%@| @}


@%\subsection{Print the paragraphs with annotations}
@%\label{sec:printannotated}
@%
@%If there is no concept, print everything in
@%one blow. Otherwise, get an array with the numbers of the active concepts.
@%
@%@d annotate and print the paragraphs @{@%
@%if(\$conceptset->active_concept_count==0){
@%@%  printf("%s", utf8_encode(str_replace("\n","<br>\n",rtrim(\$tekst))));
@%  return  utf8_encode(str_replace("\n","<br>\n",rtrim(\$tekst)));
@%};
@%\$ca=\$conceptset->arra();
@%@| \$ca @}
@%
@%
@%To enable to handle the paragraphs and the strings that match the
@%fingerprints in an ordered manner, create inverse arrays, from which
@%we can pop off the offsets that we have processed. The offsets of the
@%paragraphs are listed in array \verb|\$rpb|. In a while loop,
@%process the next paragraph and then pop its offset of the array, until
@%the array is empty.
@%
@%On second thoughts, usage of inverse arrays and popping of elements
@%does not seem the most convenient method. Using the array function
@%\verb|current()|, \verb|next()| and \verb|reset()| seems to be at
@%least as convenient. But we leave this for another time.
@%
@%@d annotate and print the paragraphs @{@%
@%@%@< create reverse arrays with fingerprint offsets @>
@%@< create reverse arrays with paragraphs offsets @>
@%while(end(\$rpb)!=FALSE){
@%  \$parstart=array_pop(\$rpb);
@%  \$parlength=array_pop(\$rpl);
@%  \$parend=\$parstart+\$parlength;
@%  @< process the next paragraph @>
@%};
@%@| \$parstart \$parlength \$parend @}
@%
@%
@%@%@d create reverse arrays with fingerprint offsets @{@%
@%@%foreach(\$ca as \$conceptnum){
@%@%  if(array_key_exists(\$conceptnum,\$conweight)){
@%@%    foreach(\$conweight[\$conceptnum] as \$fpcounter => \$weight){
@%@%      \$revoff[\$conceptnum][\$fpcounter]=array_reverse(\$conoff[\$conceptnum][\$fpcounter]);
@%@%      \$revlen[\$conceptnum][\$fpcounter]=array_reverse(\$conlen[\$conceptnum][\$fpcounter]);
@%@%    };
@%@%  };
@%@%};
@%@%@| \$revoff \$revlen @}
@%
@%@d create reverse arrays with paragraphs offsets @{@%
@%\$rpb=array_reverse(\$pb);
@%\$rpl=array_reverse(\$pl);
@%@| @}
@%
@%To print a paragraph with annotations (highlihting and highlighted
@%phrases), do the following:
@%
@%@%\begin{enumerate}
@%@%\item Loop over the active concepts, to find matching phrases in the
@%@%  paragraph. Count the number of matches. Put the offsets and lengths
@%@%  of the matching phrases in array \verb|\$phraselen|.
@%@%\item Loop a second time over the active concepts, to determine
@%@%  for which of the concepts this paragraph is relevant. Construct an
@%@%  array of relevant concept numbers.
@%@%\item Print the whole paragraph if there are no relevant concepts, or, otherwise,
@%@%  print it in bits and pieces.
@%@%\end{enumerate}
@%@%
@%@%Do the following for each active concept:
@%@%\begin{enumerate}
@%@%\item Fill array \verb|\$phraselen| with the lengths of the phrases
@%@%  (using offset as key) in this paragraph.
@%@%\item Count the number of matching phrases and store this in array
@%@%  element \verb|\$phrasecount[\$conceptnum]|.
@%@%\item Count the number of matching single-word phrases and store this in array
@%@%  element \verb|\$phrasecount[\$conceptnum]|.
@%@%\item Count the total number of matching phrases and store this in \verb|\$totalmatches|
@%@%\end{enumerate}
@%
@%\begin{enumerate}
@%\item Select from array \verb|\$matcharr| the phrases that belong to
@%  the current paragraph. While doing this, count the number of phrases
@%  for each concept number.
@%\item Determine for which of the active concepts this paragraph is
@%  considered relevant.
@%\item Print the whole paragraph in an \verb|xajax| function if there
@%  are no relevant concepts, or, otherwise, print it in bits and
@%  pieces.
@%\end{enumerate}
@%
@%
@%@d process the next paragraph @{@%
@%@< select and count phrases in the current paragraph @>
@%@%@< loop over the active concepts to find matching phrases @>
@%@< loop over the active concepts to determine the relevant ones @>
@%@< actually print the paragraph @>
@%@| \$totalmatches  \$phraselen
@%   \$phrasecount \$singlewordphrasecount @}
@%
@%Select the phrases that belong to this paragraph. Put their
@%\verb|Matchingstring| objects in array \verb|\$pmatchar|. Count the
@%number of matching phrases in this paragraph and count the number of
@%matching phrases/single-word phrases for each of the concepts in array
@%\verb|\$matchesof[]| resp.\ \verb|\$singlewordmatchesof[]|.
@%
@%@d select and count phrases in the current paragraph  @{@%
@%\$totalmatches=0;
@%unset(\$pmatchar);
@%unset(\$matchesof);
@%unset(\$singlematchesof);
@%if(isset(\$matcharr)){
@%  foreach(\$matcharr as \$mat){
@%    if( (\$mat->matches_par(\$parstart, \$parlength))
@%                   &&
@%        (\$conceptset->is_active_concept(\$mat->connum()))
@%    ){
@%      \$pmatchar[]=\$mat;
@%      @< count the matches and the single-word matches @>
@%      @< count the matches for the concept number @>
@%    };
@%  };
@%};
@%@| @}
@%
@%@d count the matches and the single-word matches @{@%
@%\$totalmatches++;
@%if(\$mat->wc()==1) \$singlewordmatches++;
@%@| \$totalmatches \$singlewordmatches @}
@%
@%
@%@d count the matches for the concept number @{@%
@%@< increase array element by one @(\$matchesof[\$mat->connum()]@) @>
@%if(\$mat->wc()==1){
@%  @< increase array element by one @(\$singlematchesof[\$mat->connum()]@) @>
@%};
@%@| \$matchesof \$singlematchesof @}
@%
@%
@%If an array element does not yet exist, set it to unity. Otherwise
@%increase the existing element by unity.
@%@d increase array element by one @{@%
@%if(isset(@1)){
@%    @1++;
@%} else {
@%    @1=1;
@%};
@%
@%@| @}
@%
@%
@%If a phrase that consists of multiple words matches, the paragraph is
@%considered to be relevant for the concept.  Otherwise, if a
@%single-word phrase matches, but more phrases (probably belonging to
@%other concepts) match also, the paragraph is considered to be relevant
@%for the concept. Store the concepts for which the current paragraph is
@%relevant in array \verb|\$relevantconcepts|.
@%
@%
@%The current paragraph is relevant for a concept if at least one phrase
@%that consists of multiple words matches, or if one single-word phrase
@%matches but another phrase from another concept matches too.
@%
@%@d loop over the active concepts to determine the relevant ones @{@%
@%unset(\$relevantconcepts);
@%foreach(\$ca as \$conceptnum){
@%  if(\$matchesof[\$conceptnum]==0) continue;
@%  if(\$matchesof[\$conceptnum]==2){
@%    insert_value_into_array(\$relevantconcepts, \$conceptnum);
@%    continue;
@%  };
@%  # one match.
@%  if(\$singlematchesof[\$conceptnum]>0){
@%    if(\$totalmatches>1){
@%      insert_value_into_array(\$relevantconcepts, \$conceptnum);
@%      continue;
@%    };
@%  };
@%  # one match, multiple words
@%  insert_value_into_array(\$relevantconcepts, \$conceptnum);
@%};
@%@%  if(array_key_exists(\$conceptnum,\$conweight)){
@%@%    if(  (\$phrasecount[\$conceptnum]>0)
@%@%                      ||
@%@%       ((\$singlewordphrasecount[\$conceptnum]>0)&&(\$totalphrases>1))
@%@%      ) insert_value_into_array(\$relevantconcepts,\$conceptnum);
@%@%  };
@%@%};
@%@| @}
@%
@%@%@d remove the irrelevant phrases @{@%
@%@%foreach(\$pmatchar as \$i => \$mat){
@%@%  if(!in_array(\$mat->connum(), \$relevantconcepts)) unset(\$pmatchar[\$i]);
@%@%};
@%@%@| @}
@%
@%
@%
@%@%@d loop over the active concepts to find matching phrases @{@%
@%@%\$totalmatches=0;
@%@%unset(\$phraselen);
@%@%foreach(\$ca as \$conceptnum){
@%@%
@%@%
@%@%  \$phrasecount[\$conceptnum]=0;
@%@%  \$singlewordphrasecount[\$conceptnum]=0;
@%@%  if(array_key_exists(\$conceptnum,\$conweight)){
@%@%    foreach(\$conweight[\$conceptnum] as \$fpcounter => \$weight){
@%@%      while(is_in_range(1, end(\$revoff[\$conceptnum][\$fpcounter]), (\$parend-1))){
@%@%        \$totalmatches++;
@%@%        \$phraselen[\$conceptnum][array_pop(\$revoff[\$conceptnum][\$fpcounter])]=
@%@%             array_pop(\$revlen[\$conceptnum][\$fpcounter]);
@%@%        \$phrasecount[\$conceptnum]=\$phrasecount[\$conceptnum]+1;
@%@%        if(\$conwc[\$conceptnum][\$fpcounter]==1){
@%@%           \$singlewordphrasecount[\$conceptnum]=\$singlewordphrasecount[\$conceptnum]+1;
@%@%        };
@%@%      };
@%@%    };
@%@%  };
@%@%};
@%@%@| @}
@%
@%
@%
@%@%@d loop over the active concepts to determine the relevant ones @{@%
@%@%unset(\$relevantconcepts);
@%@%foreach(\$ca as \$conceptnum){
@%@%  if(array_key_exists(\$conceptnum,\$conweight)){
@%@%    if(  (\$phrasecount[\$conceptnum]>0)
@%@%                      ||
@%@%       ((\$singlewordphrasecount[\$conceptnum]>0)&&(\$totalphrases>1))
@%@%      ) insert_value_into_array(\$relevantconcepts,\$conceptnum);
@%@%  };
@%@%};
@%@%@|\$relevantconcepts  @}
@%
@%If the paragraph is relevant for at least one of the concepts, wrap it
@%in highlighting tags and wrap the phrases in tags. Otherwise, just
@%print the paragraph.
@%
@%@d actually print the paragraph @{@%
@%if(isset(\$relevantconcepts)){
@%  @< print the paragraph in bits and pieces @>
@%} else {
@%  @< print the paragraph on user-request @(\$parstart@,\$parlength@) @>
@%};
@%@| @}
@%
@%If the paragraph is not relevant, print it only if the user requested
@%it. In that case variable \verb|\$entire| has been set to \verb|TRUE|
@%(see~\autoref{scr:printannotatedverdict}).
@%
@%@d print the paragraph on user-request @{@%
@%  if(\$entire==TRUE){
@%    \$uittext=\$uittext."<p>";
@%    \$uittext=\$uittext.utf8_encode(str_replace("\n","<br>\n",rtrim(substr(\$tekst,(@1-1),@2))));
@%    \$uittext=\$uittext."</p>\n";
@%  } else {
@%    \$uittext=\$uittext." ... ";
@%  };
@%@| @}
@%
@%Otherwise, print the paragraph and highlite important phrases.
@%
@%Wrap a relevant paragraph in \verb|span| tags.
@%
@%@d print the paragraph in bits and pieces @{@%
@%@< print the paragraph opening mark @>
@%@< print the texts and the phrases @>
@%@< print the paragraph closing mark @>
@%
@%@| @}
@%
@%
@%To highlight a paragraph, wrap it into \verb|<p>| tags with a
@%\qstring{class} modifier. The Cascaded Stylesheet ought to contain make-up
@%instructions to achieve the highlighting effect. The following
@%function generates a name that consists of a concatenation of the
@%letter \verb|p| and the sequence numbers of the relevant concepts in
@%alphabetical expression (\verb|one|, \verb|two| or \verb|three|)..
@%
@%@d php functions @{@%
@%function concepttagclass(\$relevantconcepts){
@%  global \$conceptset;
@%  \$conceptcount=0;
@%  \$taglabel="p";
@%  sort(\$relevantconcepts);
@%  for(\$i=1;\$i<=m4_nrofconcepts;\$i++){
@%    if(in_array(\$i,\$relevantconcepts)){
@%      \$conceptcount++;
@%      \$taglabel=\$taglabel.telwoordvan(\$conceptset->concept_seqnum(\$i));
@%      if(\$conceptcount>=m4_maxactiveconcepts) break;
@%    };
@%  };
@%  return \$taglabel;
@%}
@%@| concepttagclass @}
@%
@%
@%
@%@d print the paragraph opening mark @{@%
@%\$uittext=\$uittext."\n<p class=\"".concepttagclass(\$relevantconcepts)."\">\n";
@%@% printf("\n<p class=\"%s\">\n", concepttagclass(\$relevantconcepts));
@%@| @}
@%
@%@d print the paragraph closing mark @{@%
@%@% printf("\n</p>\n", concepttagclass(\$relevantconcepts));
@%\$uittext=\$uittext."\n</p>\n";
@%@| @}
@%
@%
@%Print the paragraph as follows: Offset pointer \verb|\$bp| points initially to
@%the begin of the paragraph. Find the first matching phrase. Print the
@%text from \verb|\$bp| up to this phrase, print an appropriate \verb|<span>| tag, print
@%the phrase and print the \verb|</span>| tag. Make \verb|\$pb| point to
@%the first character after the phrase and repeat until all phrases have
@%been printed. Then, print the remainder of the paragraph.
@%
@%@d print the texts and the phrases @{@%
@%\$bp=\$parstart;
@%while(nextphrase(\$bp, \$pmatchar, \$phrasbegin, \$phraslen, \$classname)){
@%  @< print upto/including the matching phrase @>
@%  \$bp=\$phrasbegin+\$phraslen;
@%}; 
@%@< print the remainder of the paragraph @>
@%@| @}
@%
@%The following boolean function finds the offset, the length and a span class
@%name of the first matching phrase. It results whether such a phrase
@%could be found. As a side effect, it removes the offset of the phrase
@%off the array \verb|\$phraslen|.
@%
@%The algorithm to select the phrases to be marked and to determine the
@%way how they should be marked can be made very complicated if we take
@%all kind of overlappings into account. For now, we keep things simple
@%and just mark the first phrase that we find.
@%
@%@d php functions @{@%
@%function nextphrase(\$bp, &\$pmatchar, &\$offset, &\$len, &\$classname){
@%  global \$conceptset;
@%  \$offset=0;
@%  \$len=0;
@%  \$weight=0;
@%  \$foundone=FALSE;
@%  if(isset(\$pmatchar)){
@%    foreach(\$pmatchar as \$i => \$mat){
@%      if(\$mat->offset()<\$bp){
@%        unset(\$pmatchar[\$i]);
@%        continue;
@%      };
@%      if(  (\$mat->offset()<\$offset)
@%                  || 
@%          (\$offset==0)
@%                  ||
@%         ( (\$mat->offset()==\$offset) && (\$mat->weight>\$weight) )
@%        ){
@%        \$foundone=TRUE;
@%        \$offset=\$mat->offset();
@%        \$len=\$mat->length();
@%        \$weight=\$mat->weight();
@%        \$classname="f".telwoordvan(\$conceptset->concept_seqnum(\$mat->connum()));
@%        unset(\$pmatchar[\$i]);
@%      }
@%    };
@%  };
@%  return \$foundone;
@%}
@%
@%@| nextphrase @}
@%
@%
@%@d print upto/including the matching phrase @{@%
@%@< print part of the text @(\$bp@,(\$phrasbegin-\$bp)@) @>
@%\$uittext=\$uittext."<span class=\"".\$classname."\">\n";
@%@< print part of the text @(\$phrasbegin@,\$phraslen@) @>
@%\$uittext=\$uittext."\n</span>\n";
@%\$bp=\$phrasbegin+\$phraslen;
@%@| @}
@%
@%@d print the remainder of the paragraph @{@%
@%@< print part of the text @(\$bp@,\$parend-\$bp@) @>
@%@%printf("</p>\n");
@%\$uittext=\$uittext."</p>\n";
@%@| @}
@%
@%
@%
@%@d print part of the text @{@%
@%\$uittext=\$uittext.utf8_encode(str_replace("\n","<br>\n",rtrim(substr(\$tekst,(@1-1),@2))));
@%@| @}

\subsection{Add explanations}
\label{sec:addexplanations}

Find legalese words in the text and replace them by clickable elements
that invoke pop-up%
\index{pop-up}
windows with the explanation.
@% (section~\autoref{sec:popup}.

The file~\url{m4_legalesefil} contains explanations for legal
terms. Each line of this file begins with a legal term, followed by a
\emph{tab} character, followed by explaining text. The
function~\verb|wordtotooltip|
@% (in \autoref{wordtotooltipsection})
replaces in a text-string the legalese words by references to tooltips.

@d add legalese explanations to @{@%
\$explaintext = new Explaintexts;
@1=\$explaintext->wordtotooltip(@1);
@%if(\$legahandle = fopen("m4_legalesefil", "rb")){
@%  while(!feof(\$legahandle)){
@%    \$legarr = explode("\t", rtrim(fgets(\$legahandle)));
@%    if(\$legarr[0]!=""){
@%      \$legawoord=strtolower(\$legarr[0]);
@%      @< create pop-info for a legalese term @>
@%    };
@%  };
@%  fclose(\$legahandle);
@%};
@| \$legahandle  \$legawoord @}

@%Replace instances in the text with the \textsc{html} code
@%to invoke the help window. If such instances exist, generate the
@%Javascript code to produce the pop-up. Replace the lowercased, the
@%capitalised and the uppercased version of the legalese-word.
@%
@%@d create pop-info for a legalese term @{@%
@% \$pattern=array(
@%        0 => "/".strtolower(\$legawoord)."/",
@%        1 => "/".ucfirst(\$legawoord)."/",
@%        2 => "/".strtoupper(\$legawoord)."/"
@% );
@% @< build a html a tag as replacement @(\$i@) @>
@% ksort(\$pattern);
@% ksort(\$replacement);
@% $paattern="/omkeringsregel/";
@% $replac="aapnootMies";
@% \$uittext=preg_replace(\$pattern, \$replacement,\$uittext,-1,\$replcount);
@%@% if(\$replcount>0){
@%@%   @< generate Javascript function to create the help-window @>
@%@% }; 
@%@| @}
@%
@%The code to invoke the help window consists of a \verb|<a>| tag with
@%an \verb|onmouseover| instruction that calls a Javascript function
@%that produces the help window.
@%
@%Generate a name for this function:
@%
@%@d build a html a tag as replacement @{@%
@% \$funcnam=strtolower(\$legarr[0]); 
@%@| \$funcnam @}

@%Replace the word by the tag:
@%
@%@d build a html a tag as replacement @{@%
@%\$replastring="<a href=\"index.php\" ";
@%\$replastring=\$replastring."onmouseover=\"".\$funcnam."('open')\" ";
@%\$replastring=\$replastring."onmouseout=\"".\$funcnam."('close')\" ";
@%\$replastring=\$replastring.">";
@%\$replastring=\$replastring."aapnootMies";
@%\$replastring=\$replastring."</a>";
@%\$replacement = array(
@%  0 => preg_replace("/aapnootMies/", \$legawoord, \$replastring),
@%  1 => preg_replace("/aapnootMies/", ucfirst(\$legawoord), \$replastring),
@%  2 => preg_replace("/aapnootMies/", strtoupper(\$legawoord), \$replastring),
@%);
@%@| @}
@%
@%Generate the functions that create the windows. At this moment, we create
@%functions for every word in the list of legalese words. I should find
@%a better way to do this eventually, probably using Ajax.
@%
@%@d  Javascripts in the header @{@%
@%generate_help_windows_Javascript_functions();
@%@| @}
@%
@%
@%Open the legalese file. Read it line-by-line and create a help function.
@%@d functions of index @{@%
@%function generate_help_windows_Javascript_functions(){
@%  printf("<!--- Hier komen de scripts voor de pop-ups -->\n");
@%  if(\$legahandle = fopen("m4_legalesefil", "rb")){
@%    printf("<script type=\"text/javascript\">\n");
@%    @< create an option string for the pop-up windows @>
@%    while(!feof(\$legahandle)){
@%      \$legarr = explode("\t", rtrim(fgets(\$legahandle)));
@%      if(\$legarr[0]!=""){
@%        \$legawoord=strtolower(\$legarr[0]);
@%        @< create a pop-up javascript function @>
@%      };
@%    };
@%    fclose(\$legahandle);
@%    printf("</script>\n");
@%  printf("<!--- Dit waren de scripts voor de pop-ups -->\n");
@%  };
@%  return;
@%};
@%@| generate_help-windows_Javascript_functions @}
@%
@%
@%
@%@d create a pop-up javascript function @{@%
@%?>
@%function <?php printf("%s", \$legawoord);?>(arg){
@%  if(arg=='open'){
@%    helpwin = window.open("", "hwin", config="<?php printf("%s", \$opstring) ?>");
@%    helpwin.document.write("<html><head></head><body>");
@%    helpwin.document.write("<?php printf("<H1>%s</H1>", \$legarr[0]); ?>");
@%    helpwin.document.write("<?php printf("<p>%s</p>", \$legarr[1]); ?>");
@%    helpwin.document.write("</body></html>");
@%  };
@%  if(arg=='close'){
@%    helpwin.close();
@%  };
@%};
@%<?php
@%@| @}
@%
@%The options for the pop-up window.
@%@d create an option string for the pop-up windows @{@%
@%@%  \$opstring="height=100, width=400, ";
@%  \$opstring="height=400, width=400, ";
@%  \$opstring=\$opstring."toolbar=no, menubar=no, scrollbars=no, ";
@%  \$opstring=\$opstring."resizable=no, location=no, ";
@%  \$opstring=\$opstring." directories=no, status=no";
@%@| \$opstring @}
@%

@%    <A HREF="inwind.html"
@%      onmouseover="poep=window.open('inwind.html', 'joe',
@%         config='height=200,width=200,screenX=0,screeny=0')" 
@%      onmouseout="poep.close()"
@%      >Klik dan hier</A></p>

\subsection{Wrap into Ajax function}
\label{sec:wrapinajax}

To enable fast reloading of the verdict, we create an xajax function
that calls the above defined function \verb|printannotatedverdict| in
the proper way, and sends the produced string to the remote website
for displaying.

The \textsc{html} code in the body of the web page contains
placeholders that will be filled in by the xajax function.

@d placeholder for the annotated verdict @{@%
printf("<div id=\"verdictplace\"></div>\n");
@| @}

@d  button to select entire doc or relevant parts only @{@%
printf("<div id=\"textmodebutton\"></div>");
@%printf("<button ");
@%printf(   "onclick=\"");
@%printf(      "xajax_printhelemaal(");
@%printf(         "<div id=\"printhelemaalarg\"></div>");
@%printf(      ")");
@%printf(   "\"");
@%printf(">");
@%printf(  "<div id=\"textselectionbuttontext\">");
@%printf(  "</div>");
@%printf("</button>\n");
@| @}

The xajax function \verb|printhelemaal| generates the \textsc{html}
code of an annotated verdict and it generates the argument for itself
within a button with which the user can switch between displaying the
entire document or only the relevant parts.

\textbf{Note:} in \php{}, 0 is associated with \qstring{false} and~1
associated with \qstring{true}.

@d php xajax functions @{@%
function printhelemaal(\$filnam, \$entire){
  global \$conceptset;
@% \$conceptset=new Conceptset;
 \$objResponse = new xajaxResponse();
 \$nextentire=(\$entire==0 ? 1 : 0);
 if(\$conceptset->active_concept_count>0){
   \$buttontext=(\$entire==0 ? "Toon document compleet" : "Toon alleen relevante delen");
   \$buttonstring='<button onclick=\'xajax_printhelemaal("';
   \$buttonstring=\$buttonstring.\$filnam;
   \$buttonstring=\$buttonstring.'",';
   \$buttonstring=\$buttonstring.\$nextentire;
   \$buttonstring=\$buttonstring.')\'>'.\$buttontext.'</button>';
   \$objResponse->addAssign("textmodebutton","innerHTML", \$buttonstring);
 };
 \$objResponse->addAssign("textselectionbuttontext","innerHTML", \$buttontext);
 \$objResponse->addAssign("verdictplace","innerHTML",printannotatedverdict(\$filnam,\$entire));
@% \$objResponse->addAssign("verdictplace","innerHTML","Aap noot Mies");
@% addAssign("div1","innerHTML",\$intext);
 return \$objResponse;
}
@| printhelemaal \$objResponse @}


@%@d php xajax functions @{@%
@%function printhelemaal(\$uri, \$entire){
@% global \$conceptset;
@% \$conceptset=new Conceptset;
@% \$objResponse = new xajaxResponse();
@% \$nextentire=(\$entire==0 ? 1 : 0);
@% if(\$conceptset->active_concept_count>0){
@%   \$buttontext=(\$entire==0 ? "Toon document compleet" : "Toon alleen relevante delen");
@%   \$buttonstring='<button onclick=\'xajax_printhelemaal("';
@%   \$buttonstring=\$buttonstring.\$filnam;
@%   \$buttonstring=\$buttonstring.'",';
@%   \$buttonstring=\$buttonstring.\$nextentire;
@%   \$buttonstring=\$buttonstring.')\'>'.\$buttontext.'</button>';
@%   \$objResponse->addAssign("textmodebutton","innerHTML",
@%   \$buttonstring);
@% };
@%@% \$objResponse->addAssign("textselectionbuttontext","innerHTML", \$buttontext);
@% \$objResponse->addAssign("verdictplace","innerHTML",printannotatedverdict(\$filnam,\$entire));
@%@% addAssign("div1","innerHTML",$intext);
@% return \$objResponse;
@%}
@%@| printhelemaal \$objResponse @}



@d register xajax functions @{@%
\$xajax->registerFunction("printhelemaal");
@| @}

Invoke the xajax function on load if we have to display a verdict.

@d init javascript @{@%
if(parameter_value_of('m4_filenamekeyword')!=""){
  printf("<script type=\"text/javascript\">\n");
  printf("xajax_printhelemaal(\"%s\",0)\n", parameter_value_of('m4_filenamekeyword'));
  printf("</script>\n");
};
@| @}




@d variables of printannotatedverdict @{@%
  \$irrelsecnum=0;
@| \$irrelsecnum @}

@%@d button to select entire doc or relevant parts only @{@%
@%    <button onclick="xajax_printhelemaal(0)">Niet aankomen!</button>
@%@| @}



Print an irrelevant paragraph as it is.
@d just print the paragraph @{@%
printf("<p>");
\$irrelsecnum++;
\$irrelsecname="irrelsec".\$irrelsecnum;
@< print the placeholder for part of the text @(\$parstart@,\$parlength@) @>
@< add the text to ajax function@(\$parstart@,\$parlength@)  @>
printf("</p>\n");
@| @}

@d print the placeholder for part of the text @{@%
printf("<div id=\"%s\"></div>\n", \$irrelsecname)
@| @}







To visualise the annotations we use \verb|<span>| tags. The mark-up is
determined in the cascaded style sheet. The \verb|<span>| class
\verb|m4_conceptparone| serves to typeset paragraphs to be annotated
and  the class \verb|m4_conceptwordone| serves to typeset phrases to
be annotated.


\subsubsection{Copy and annotate}
\label{sec:copyandannotate}

To copy the verdict onto the screen of the user, with annotations,
proceeds as follows:

\begin{enumerate}
\item Read the entire text of the verdict into string \verb|\$tekst|.
\item Copy a chunk of the text in variable \verb|\$chunk|.
\item Prepend the line-feed characters in the chunk with \verb|<br>| tags.
\item If the chunk is to be annotated, print annotation code.
\item print the chunk.
\item If the chunk is at the end of an annotated section, print
  end-annotation code.
\end{enumerate}

The variable \verb|\$offset| is a pointer to the first character in
the \verb|\tekst| array that still has to be copied. Initially it has
a value of~1.


@%@d print the annotated verdict @{@%
@%\$currloc=setlocale(LC_ALL,0);
@%@%printf("\n<!--- locale: %s --->\n", \$currloc);
@%@< init print the annotated verdict @>
@%
@%@< read the text of the verdict @>
@%\$offset=1;
@%@< copy chunks @>
@%@| @}

@%Currently we produce ordinary text and text that is marked up as
@%relevant paragraph or as relevant phrase. Model this as an automaton
@%with the following three states:
@%
@%\begin{description}
@%\item[ordinary:] Copy ordinary text.
@%\item[annotated-paragraph:] Copy text in an annotated paragraph.
@%\item[annotated-phrase:]  Copy text in an annotated phrase.
@%\end{description}
@%
@%The \qstring{annotated-phrase} mode is a sub-mode of the
@%\qstring{annotated-paragraph} mode. The position of the pointer
@%\verb|\offset| determines how the state changes. See
@%figure~\ref{fig:markstate}.
@%\begin{figure}[hbtp]
@%  \centering
@%  \includegraphics{annotatestate.fig}
@%  \caption{State changes to mark up chunks of text}
@%  \label{fig:markstate}
@%\end{figure}
@%
@%
@%
@%@d copy chunks @{@%
@%\$state="ordinary";
@%@%\$i=0;
@%while(\$offset<strlen(\$tekst)){
@% @< change markup state @>
@% printf("<!---Offset: %d; state: %s  --->\n", \$offset, \$state);
@% @< print the chunk @>
@% @< update offset pointer @>
@%@% \$i++;
@%@% if(\$i>=200) break;
@%};
@%printf("\n");
@%@| @}
@%
@%To determine how the state has to be changed, we have to compare the
@%offset pointer with the arrays \verb|m4_conceptparbegin|,
@%\verb|m4_conceptparlength|, \verb|m4_conceptwordsbegin| and
@%\verb|m4_conceptlengths|. Let us initialise these arrays, so that we
@%can get the correct values withe the \verb|current| function.
@%
@%@d  init print the annotated verdict @{@%
@%if(\$found_offsets==TRUE){
@%  reset(\$m4_conceptparbegin);
@%  reset(\$m4_conceptparlength);
@%  reset(\$m4_conceptwordsbegin);
@%  reset(\$m4_conceptlengths);
@%};
@%@| reset @}
@%
@%The state changes when the offset pointer points to the begin or and
@%of a paragraph or phrase to be marked. This macro updates the state of
@%the arrays mentioned above as well.
@% 
@%@d change markup state @{@%
@%if(\$found_offsets==FALSE){
@%   \$state="ordinary";
@%} else {
@%   if((\$state=="ordinary") && (\$offset==current(\$m4_conceptparbegin))){
@%     @< print begin-of-paragraph annotation @>
@%     \$state="paragraph";
@%   };
@%   if((\$state=="paragraph") && (\$offset==current(\$m4_conceptwordsbegin))){
@%     @< print begin-of-phrase annotation @>
@%     \$state="phrase";
@%   };
@%   if((\$state=="phrase")&& (\$offset==current(\$m4_conceptwordsbegin)+current(\$m4_conceptlengths))){
@%     @< print end-of-phrase annotation @>
@%     next(\$m4_conceptwordsbegin);
@%     next(\$m4_conceptlengths);
@%     \$state="paragraph";
@%   };
@%   if((\$state=="paragraph") 
@%                     && 
@%      (\$offset==current(\$m4_conceptparbegin)+current(\$m4_conceptparlength))
@%   ){
@%     @< print end-of-paragraph annotation @>
@%     next(\$m4_conceptparbegin);
@%     next(\$m4_conceptparlength);
@%     \$state="ordinary";
@%   };
@%};
@%@| @}
@%
@%Print the appropriate \verb|<span>| tags and replace removed trailing
@%line-feeds. When they are written on a separate line it might be
@%easier to debug this thing if necessary.
@%
@%
@%
@%@d print begin-of-paragraph annotation @{@%
@%@%if(\$offset>0) printf("<br>");
@%  \$uits=\$uits."\n<span class=\"m4_conceptparone\">\n";
@%@| @}
@%
@%
@%
@%@d print begin-of-phrase annotation @{@%
@%printf("\n<span class=\"m4_conceptwordone\">\n");
@%@| @}
@%
@%
@%Replace spaces and line-feeds at the end of annotated chunks
@%
@%@d print end-of-phrase annotation @{@%
@%printf("\n</span> \n");
@%@| @}
@%
@%
@%@d print end-of-paragraph annotation @{@%
@%\$uits=\$uits."\n</span><br>\n";
@%@| @}
@%
@%
@%
@%Now, print the chunk. First determine the size of the chunk. Then,
@%process and copy the chunk. Processing involves:
@%
@%\begin{itemize}
@%\item trim trailing spaces and line-breaks, to prevent ugly annotation
@%  where the high-lighting background color extends over the trailing
@%  space end bumps into the following uncoloured part.
@%\item Prepend line-feeds with \verb|<br>| tags.
@%\item Recode \textsc{utf8}. Unfortunately this does not work yet.
@%\end{itemize}
@%
@%@d print the chunk @{@%
@%@< determine the size of the chunk to be copied @>
@%printf("%s",utf8_encode(str_replace("\n","<br>\n",rtrim(substr(\$tekst,\$offset-1,\$chunksize)))));
@%@| @}
@%
@%
@%@d determine the size of the chunk to be copied @{@%
@%if(\$state=="phrase"){
@%  \$chunksize=current(\$m4_conceptlengths);
@%};
@%if(\$state=="paragraph"){
@%  printf("<!---offset: %d; BOP: %d; LOP: %d --->\n", \$offset, current(\$m4_conceptwordsbegin), current(\$m4_conceptlengths));
@%  if((\$offset<=current(\$m4_conceptwordsbegin)) 
@%               && 
@%     (current(\$m4_conceptwordsbegin)<\$offset+current(\$m4_conceptparlength))
@%    ){
@%      \$chunksize=current(\$m4_conceptwordsbegin)-\$offset;
@%      printf("<!---Until phrase. Size: %d  --->\n", \$chunksize);
@%  } else {
@%    \$chunksize=current(\$m4_conceptparbegin)+current(\$m4_conceptparlength)-\$offset;
@%      printf("<!---rest of paragraph: Size: %d  --->\n", \$chunksize);
@%  };
@%};
@%if(\$state=="ordinary"){
@%  if((\$found_offsets==FALSE) || current(\$m4_conceptparbegin)<=0){
@%    \$chunksize=strlen(\$tekst)-(\$offset-1);
@%  } else {
@%    \$chunksize=current(\$m4_conceptparbegin)-\$offset;
@%  };
@%  printf("<!---Chunksize: %d  --->\n", \$chunksize);
@%};
@%@| @}
@%
@%@d update offset pointer @{@%
@%\$offset+=\$chunksize;
@%@| @}

@%\section{The web-site pages}
@%\label{sec:Web-pages}
@%
@%m4_dnl
@%m4_dnl Een template voor een php pagina:
@%m4_dnl arg 1: locatie van de pagina tov de root
@%m4_dnl arg 2: titel
@%m4_dnl
@%m4_dnl
@%m4`'_define(m4_nieuwepag,
@%`@o m4_webdir`'/\$1.php @{@< standaardinhoud @(\$2@) @>
@%m4_dnl \$
@%<?php
@%
@%function content(){
@%@%global @< globale parameters @>;
@%  @<content van \$1 @>
@%}
@%
@%@< functions of \$1 @>
@%?>
@%
@%@| @}
@%')m4_dnl
@%m4_dnl
@%m4_dnl
@%m4`'_define(m4_kop, printf("<H1>%s</H1>\n", \$1);)m4_dnl
@%m4_dnl
@%
@%The web site is built in directory \url{file://m4_webdir}. The
@%\textsc{url} of the root is \url{m4_webURL}. Create this directory if
@%it doesn't exist yet.
@%
@%m4`'_nieuwedir(m4_webdir)m4_dnl
@%
@%\subsection{Test homepage}
@%\label{sec:testhomepage}
@%
@%
@%At this moment, we have a test homepage that shows the two display
@%modes. In the concept-oriented mode, one out of the currently
@%available~m4_nrofconcepts concepts for which relevant verdicts are
@%available can be selected. In the case-oriented mode, documents
@%that are relevant for a combination of concepts can be selected.
@%
@%@%m4`'_nieuwepag(index, `Display')m4_dnl
@%
@%Find out the mode that has to be used.
@%


\chapter{Resources}
\label{chap:resources}

\section{Interface with the ontology}
\label{sec:ontology-interface}

The class \verb|ontologyconnect| serves as an interface with the
ontology. Currently it provides the following:
\begin{description}
\item[\texttt{\`'\$rdfs\_subclass}:] Rdf \emph{Subclass} predicate for concepts
  that indicates that the object is a specialisation of the subject. \\ 
 
\item[\texttt{\`'\$rdfs\_comment}:] \emph{Comment} predicate. The
  object is an explanatory text of the subject, a legal concept. \\
\item[\texttt{\`'\$best\_preflabel}:]  \emph{Preflabel} predicate.
  The subject is a legal concept and the object is the title of this concept. \\ 
\item[\texttt{\`'\$selectquery(\`'\$query)}:] perform a \sparql{}
  \emph{select} query and return the \xml{}-encoded
  response. \\
\item[\texttt{get\_single\_element\_from\_queryxmlresult(\`'\$qresult,\`'\$type)}:]
  Decode the \xml{} result from a \sparql{} query that produces a list
  of single elements.
\end{description}

@o m4_libdir/m4_packagename.ontologyconnect.php @{@%
<?php
  require_once "HTTP/Request.php";
  @< code of ontologyconnect.php @>
?>
@| @}

@d code of ontologyconnect.php @{@%
class Ontologyconnect{
  @< variables of the Ontologyconnect class @>
  @< methods of the Ontologyconnect class @>

}

@| Ontologyconnect @}

@d methods of the Ontologyconnect class @{@%
function __construct(){
  @< construction of the Ontologyconnect class @>
}

@| @}

\subsection{The location of the ontology and url's}
\label{sec:ontolocation}

\subsubsection{The ontology}
\label{sec:ontologylocation}

Provide the location of the ontology, i.e.{} the host and the name of
the repository that contains the ontology.

@d variables of the Ontologyconnect class @{@%
  var \$host="m4_ontologyhost";
  var \$port="m4_ontologyport";
  var \$ontoname="m4_ontologyname";
  var \$repositoriesdir="m4_repositoriesdir";
  var \$repo_url;
@| \$host \$port \$ontoname @}

Create an \textsc{url} of the repository:

@d construction of the Ontologyconnect class @{@%
\$this->repo_url=\$this->host.":".\$this->port."/".\$this->repositoriesdir."/".\$this->ontoname;
@| repo_url @}


\subsubsection{Namespaces}
\label{sec:Namespaces}

Table~\ref{tab:namespaces}
\begin{table}[hbtp]
  \centering
  \begin{tabular}{ll}
    \textbf{symb.} & \textbf{full name} \\
      best & \url{m4_nsbest} \\
      owl  & \url{m4_nsowl} \\
      rdf  & \url{m4_nsrdf} \\
      rdfs & \url{m4_nsrdfs} \\
      xsd  & \url{m4_nsxsd}
  \end{tabular}
  \caption{Namespaces in use}
  \label{tab:namespaces}
\end{table}
 lists the namespaces are in use in the \texttt{best} ontology. In
 this program we will not use the name-space abbreviations but the
 full uri's including the namespace. Store the namespaces in
 variables:

@d variables of the Ontologyconnect class @{@%
var \$ns_best="m4_nsbest";
var \$ns_owl="m4_nsowl";
var \$ns_rdf="m4_nsrdf";
var \$ns_rdfs="m4_nsrdfs";
var \$ns_xsd="m4_nsxsd";
@| \$ns_best \$ns_owl \$ns_rdf \$ns_rdfs \$ns_xsd @}


The following method constructs
an uri from a namespace and an identifier:

@d methods of the Ontologyconnect class  @{@%
function curi(\$ns,\$id){
  return "<".\$ns.\$id.">";
}
@| curi @}

To print a full url in a web page, replace the \qstring{$<$} and
\qstring{$>$} characters in it by strings that are acceptable for
\textsc{html}. 

@d methods of the Ontologyconnect class  @{@%
function unhook_uri(\$uri){
  \$pat[0]="/\</";
  \$rep[0]="&#60";
  \$pat[1]="/\>/";
  \$rep[1]="&#62";
  return preg_replace(\$pat, \$rep, \$uri) ;
}

@| unhook_uri @}
 


Construct predicate uri's that we will need:

@d variables of the Ontologyconnect class @{@%
public \$rdfs_subclass;
public \$rdfs_comment;
public \$best_preflabel;
@| @}

@d construction of the Ontologyconnect class @{@%
\$this->rdfs_subclass=\$this->curi(\$this->ns_rdfs, "subClassOf");
\$this->rdfs_comment=\$this->curi(\$this->ns_rdfs, "comment");
\$this->best_preflabel=\$this->curi(\$this->ns_best, "prefLabel");
@%\$this->rdfs_subclass=\$this->curi(\$this->ns_rdfs, "comment");
@| rdfs_subclass @}

\subsection{Perform queries}
\label{sec:performqueries}

To retrieve information from the ontology, the
\texttt{Ontologyconnect} class performs queries. In our application we
will use the \sparql{}\index{sparql}\index{Sparql} query-language
(\url{http://www.w3.org/TR/rdf-sparql-query}).


Perform a \qstring{select} query and return the \xml{}-coded
response. Argument: the query.
@d methods of the Ontologyconnect class @{@%
function selectquery(\$query){
  \$questar=array('query'=>\$query, 'queryLn'=>"m4_querylanguage");
  \$extendedurl=\$this->repo_url."?".http_build_query($questar);
  \$req=& new HTTP_Request($extendedurl);
  \$req->addHeader('Accept', 'application/sparql-results+xml, */*;q=0.5');
  if (PEAR::isError(\$req->sendRequest())) {
    return FALSE;
  } else {
    return \$req->getResponseBody();
  };
}

@| selectquery @}

The query results in a complicated \xml{} string. If the result ought
to be a single element, it can be extracted with the following method:

@d  methods of the Ontologyconnect class @{@%
function get_single_element_from_queryxmlresult(\$qresult, \$type){
  if(\$qresult===FALSE){
    return FALSE;
  } else {
    \$xml=new SimpleXMLElement(\$qresult);
    @< extract the proper type @(literal@) @>
    @< extract the proper type @(uri@) @>
  };
}

@| get_single_element_from_queryxmlresult @}

@d extract the proper type @{@%
if(\$type=="@1") return \$xml->results[0]->result[0]->binding[0]->@1[0];
@| @}


@d get element from xml of query-result @{@%
if(\$response===FALSE){
  \$this->explanation=FALSE;
} else {
  \$xml=new SimpleXMLElement(\$response);
  \$this->title=\$xml->results[0]->result[0]->binding[0]->@1[0];
};

@| @}


Perform a query to retrieve a single object element. Arguments: 1)
subject, 2) predicate and 3) type of the result (e.g.{} \qstring{literal} or
\qstring{uri}.

@%@d methods of the Ontologyconnect class @{@%
@%function get_object_element(\$subject, \$predicate, \$type){
@%  \$query="select ?x where { ".\$subject." ".\$predicate." ?x }";
@%  \$response= \$this->selectquery(\$query);
@%  if(\$response===FALSE) return FALSE;
@%  \$xml=new SimpleXMLElement(\$response);
@%  @< extract the proper type @(literal@) @>
@%  @< extract the proper type @(uri@) @>
@%}
@%
@%@| @}

@d methods of the Ontologyconnect class @{@%
function get_object_elements(\$subject, \$predicate, \$type){
  \$query="select ?x where { ".\$subject." ".\$predicate." ?x }";
  \$response= \$this->selectquery(\$query);
  if(\$response===FALSE) return FALSE;
  \$xml=new SimpleXMLElement(\$response);
  @< extract array of the proper type @(literal@) @>
  @< extract array of the proper type @(uri@) @>
}

@| get_object_elements @}

@d extract array of the proper type @{@%
if(\$type=="@1") return \$xml->results[0]->result[0]->binding[0]->@1;
@| @}

\section{The Collexis search engine}
\label{sec:collexis}

To connect to Collexis and retrieve information a collexion of api's
exist. The classes for the api's are stored in the jar library
\verb|m4_extjar2|. Collexis can be connected to with
\textsc{soap}. Therefore, it should be possible to implement a
connection directly in \php{} using the description file
\texttt{collexissoaptoolbox.wsdl}. However, the latter file is
currently not available, but a Java example is available. Therefore,
we will construct a pipeline that starts up a Java program. The
following function \verb|get_related_document_refs| returns a list of
\textsc{ljn}'s and fingerprint documents related to the document of
which the name is in variable \verb|\$pointerdoc|.

@d php functions @{@%
  @< Collexis-related php functions @>
@|  @}

@d Collexis-related php functions @{@%
function get_related_document_refs(\$pointerdoc, \$collID){
  \$task='@<  the command to find documents related to  @('.\$pointerdoc.'@,'.\$collID.'@) @>';
@%  @< pemess @("<p>Task:<br>".\$task."</p>"@) @>
  return parse_collexisdocrefs(monopipe(\$task));
}

@| get_related_document_refs @}

\subsection{The Java interface program}
\label{sec:javainterface}

The task in the pipeline is, to start up a Java virtual machine that
runs the following program:

@d add java source filename @{@%
  m4_collexispackagedir/Search.java \
@| @}

@o m4_srcdir/m4_collexispackagedir/Search.java @{@%
package m4_collexispackagename;
@< import packages into Search.java @>
/**
 * @@author mcaklein
 *
 */
public class Search {

  public static void main(String[] args) {
    String result;
      @< get the concept ID and the collection id as arguments @>
@%    @< get the fingerprint fp as argument @>
@%    @< get the collection ID as argument @>
    try {
      @< connect to collexis and get doclist in result @>
      @< print the xml doclist directly @>
@%    @< Parse result with SAX @>
    }   
    @< catch java rt error @%
       @(FactoryConfigurationError@,cannot get document builder factory@) @>
    @< catch java rt error @(IOException@,i/o exception@) @>
    @< catch java rt error @(Exception@,don't know@) @>
  };
}

@| @}

The user should provide the name of the concept and the ID of the
collection as arguments. A problem is, that the concept name may
contain \verb|(@@#$%^&*!!!)| spaces\index{spaces, damned}.
Therefore, concatenate all the args, except the last
one, as the concept name and assign the last argument as collection
ID.

@d get the concept ID and the collection id as arguments @{@%
int argtal=args.length;
String fp="m4_defaultfingerprint";
String collID = "m4_elisabethdriecollexionid";
String lastarg="";
if(argtal==1){
  fp = args[0];
} else {
  if(argtal>1){
    fp="";
    lastarg=args[0];
    for(int i=1;i<argtal;i++){
      if(fp==""){
        fp=lastarg;
      } else {
        fp=fp+" "+lastarg;
      }
      lastarg=args[i];
    };
    collID = lastarg;
  };
};
@%System.out.print("fp: "+fp+"; collID: "+collID);
@| @}



The user should provide a fingerprint code as parameter. If she does
not do this, a default value will be used.
m4_define(m4_defaultfingerprint, `fp1')m4_dnl

@d get the fingerprint fp as argument @{@%
String fp;
if(args.length<=0){
     fp = "m4_defaultfingerprint";
@%  System.out.println("Provide a fingerprint please.");
@%  System.exit(0);
} else {
    fp = args[0];
};
@| @}


@d get the collection ID as argument @{@%
String collID;
if(args.length<=1){
    collID = "m4_elisabethdriecollexionid";
} else {
   collID = args[1];
};
@%System.out.println("Use collection "+collID);
@%  System.exit(0);

@| @}

Connect to Collexis via \textsc{soap} and get an \xml{}-encoded list
of documents that are related to the document of which he name is in
the \verb|fp| variable. First, import the classes.

@d import packages into Search.java @{@%
import org.tempuri.collexissoapclient5.wsdl.CServerMatchSoapPort;
import org.tempuri.collexissoapclient5.wsdl.CollexisSoapClient5Locator;
@| @}


@d connect to collexis and get doclist in result @{@%
CollexisSoapClient5Locator collexis = new CollexisSoapClient5Locator();
CServerMatchSoapPort mySOAPport = collexis.getCServerMatchSoapPort();
result = 
  mySOAPport.getSimilar
@%  ( "306112281"
  ( collID
@%  , "<collexion name='306112281'><record id='"+fp+"'/></collexion>"
  , "<collexion name='"+collID+"'><record id='"+fp+"'/></collexion>"
  , "collexis",100,0.05f,0,"","*",200,10,0.3f,0f,0,0.4f,"","",0,0,0
  );
@%  System.out.println(result);
@| @}

Print the result directly or parse it with \textsc{sax}.

@d print the xml doclist directly @{@%
   System.out.println(result);
@| @}


Set up a \textsc{sax} \xml{} parser to parse the output and produce a
proper list.

@d import packages into Search.java @{@%
import java.io.IOException; 
import java.io.StringReader;
import javax.xml.parsers.FactoryConfigurationError;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import org.xml.sax.*;
@| @}

@d Parse result with SAX @{@%
try {
  SAXParserFactory factory = SAXParserFactory.newInstance();
  factory.setNamespaceAware(true);
  SAXParser parser = factory.newSAXParser();
  ResultHandler handler = new ResultHandler(fp);
  parser.parse(new InputSource(new StringReader(result)),handler);
}
@< catch java rt error @%
   @(ParserConfigurationException@,cannot configure parser@) @>
@< catch java rt error @%
   @(SAXException@,Parse error@) @>
@| @}

Catch run-time java errors. Generate an \xml{} type message that can
be interpreted by the simple \xml{} parser.

@d catch java rt error @{@%
catch (@1 e){
   System.out.println("<error>");
   System.out.println(" <errortyp>");
   System.out.println("   @1");
   System.out.println(" </errortyp>");
   System.out.println(" <errortext>");
   System.out.println("   @2");
   System.out.println(" </errortext>");
   System.out.println("</error>");
}
@| @}

\subsection{The ResultHandler}
\label{sec:resulthandler}

The \verb|ResultHandler| is a modification of the
\verb|DefaultHandler|, a base class of \textsc{sax2}. It accepts XML coded results from
Collexis. Especially, it manages the following metadata of verdicts:

@d variables of ResultHandler @{@%
protected String zaaknummers = "";
protected String datum = "";
protected String instantie = "";
protected String ljn = "";
@| @}


The resulthandler is able to produce an xml document with the
structure described in figure~\ref{fig:resultstruct}.
\begin{figure}[hbtp]
  \centering
\begin{verbatim}
- Warning from the Java system
<?xml ...>
<search>
  <statistics> ... </statistics>
  <times> ... </times>
  <recordlist>
    <record
      id=...
      title=...
      fingerprintlength=...
      created=...
      ...
    >
       <metainfo> ... </metainfo>
    </record>
   [<record ..> ... </record> ...]
  </recordlist>
</search>
\end{verbatim}
  \caption{The structure of the XML \qstring{result} document. We are only
    interested in the \texttt{id} attribute of the \texttt{$<$record$>$}
  tag}
  \label{fig:resultstruct}
\end{figure}
There is a \texttt{record} element for each of the documents that
Collexis has found to be similar to the given search-document. This
document is either a search document named \verb|fpnn| (with
\texttt{nn} the fingerprint number) or the \ljn{} code of a verdict.

Pass the fingerprint ID to a new object of this class:

@d variables of ResultHandler @{@%
private String fp;
@| fp @}


@d constructors of ResultHandler @{@%
public ResultHandler(String fp) {
	super();
	this.fp = fp;
}
@| @}



@d add java source filename @{@%
  m4_collexispackagedir/ResultHandler.java \
@| @}


@o m4_srcdir/m4_collexispackagedir/ResultHandler.java @{@%
/**
 * 
 */
package m4_collexispackagename;
@< import packages into ResultHandler.java @>
/**
 * @@author mcaklein
 *
 */
public class ResultHandler extends DefaultHandler {

  @< variables of ResultHandler @>
  @< constructors of ResultHandler @>
  @< methods of ResultHandler @>
}

@| @}

@d import packages into ResultHandler.java @{@%
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;
import java.lang.String;
import java.util.*;
@| @}

@d variables of ResultHandler @{@%
  protected String count = "";
  private final String READ = "READ";
  
  private Vector clusterElements = new Vector();
@| @}


@d methods of ResultHandler @{@%
@@Override
public void startDocument() throws SAXException {
	// TODO Auto-generated method stub
	System.out.println("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><ClassificationTree version=\"1.0\"><ObjectSet>");
}

@| @}

@d methods of ResultHandler @{@%
@@Override
public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException {
	// TODO Auto-generated method stub
	if (localName.equals("record")) {
		datum = "";
		instantie = "";
		zaaknummers = "";
		ljn = attributes.getValue("id");
		clusterElements.add(ljn);
		System.out.println("<Object ID=\""+ljn+"\">");
		System.out.println("<Location>http://www.rechtspraak.nl/ljn.asp?ljn="+ljn+"</Location>");
	} else if (localName.equals("datum")) {
		datum = READ;
	} else if (localName.equals("instantie")) {
		instantie = READ;
	} else if (localName.equals("zaaknummers")) {
		zaaknummers = READ;
	} else if (localName.equals("count")) {
		count = READ;
	} 
}

@| @}

@d methods of ResultHandler @{@%

@@Override
public void endElement(String uri, String localName, String qName) throws SAXException {
	// TODO Auto-generated method stub
	if (localName.equals("record")) {
		System.out.println("<Name>"+instantie+" "+datum+", "+zaaknummers+"</Name>");
		System.out.println("</Object>");
	} else if (localName.equals("count")) {
		System.out.println("<!-- "+count+" object found -->");
	}
}

@| @}

@d methods of ResultHandler @{@%

@@Override
public void characters(char[] ch, int start, int length) throws SAXException {
	// TODO Auto-generated method stub
	if (datum.equals(READ)) {
		datum = new String(ch, start, length);
	}
	if (instantie.equals(READ)) {
		instantie = new String(ch, start, length);
	}
	if (zaaknummers.equals(READ)) {
		zaaknummers = new String(ch, start, length);
	}
	if (count.equals(READ)) {
		count = new String(ch, start, length);
	}
}

@| @}

@d methods of ResultHandler @{@%

@@Override
public void endDocument() throws SAXException {
	// TODO Auto-generated method stub
	System.out.println("</ObjectSet><ClassificationSet>");
	System.out.println("<Classification ID=\""+fp+"\">");
	System.out.println("<Name>"+fp+"</Name>");
	System.out.print("<Objects objectIDs=\"");
	Iterator it = clusterElements.iterator ();
	while (it.hasNext ()) {
	   ljn = (String)it.next ();
	   System.out.print(ljn+" ");
	} 
	System.out.println("\"/></Classification>");
	System.out.println("</ClassificationSet></ClassificationTree>");
}
@| @}

\subsection{Parsing the results from Collexis}
\label{sec:parseresult}

To parse the results from Collexis, do the following: 1) get rid of
warning produced by the Java system (I do not yet not know how I can
avoid that they appear) and 2) extract for each of the record elements
the \texttt{id} attribute. The function \verb|parse_collexisdocrefs|
produces an array with the document names.

@d Collexis-related php functions @{@%
function parse_collexisdocrefs(\$str){
@%  @< pemess @("<p>Coldoc:</br>".\$coldoc."</p>"@) @>
  \$coldoc=remove_javagarbage(\$str);
  if(\$coldoc=="") return array();
  try{
    \$xml=new SimpleXMLElement(remove_javagarbage(\$coldoc));
  } catch (Exception \$e){
    printf("<p>No good XML:<br>%s</p>\n", unhook(\$coldoc));
    printf("<p>without garbage:<br>%s</p>\n", unhook(remove_javagarbage(\$coldoc)));
  };
  for(\$i=0;\$i<count(\$xml->recordlist->record);\$i++){
    \$ar[\$i]= $xml->recordlist->record[$i][id];
  };
  return \$ar;
}

@| @}

@d Collexis-related php functions @{@%
function unhook(\$instr){
  \$pat[0]="/\</";
  \$rep[0]="&#60";
  \$pat[1]="/\>/";
  \$rep[1]="&#62";
  return preg_replace(\$pat, \$rep, \$instr) ;
}
@| unhook @}


The Java \xml{} software should generate a proper \xml{} string, but
in fact it prepends the \xml{} with warnings in plain english. I do
not yet know how to avoid them. Remove these warnings. First check
whether the string actually contains \xml{}. If so, remove text that
prepends the first \xml{} tag.

@d the removejavagarbage function @{@%
  function remove_javagarbage(\$string){
    \$pattern='/<\?xml/';
    if(preg_match(\$pattern,\$string)==0) return "";
    \$pattern='/^.+<\?xml/';
    \$replacement="<?xml"; return preg_replace(\$pattern,
    \$replacement, \$string); }

@| remove_javagarbage @}

@d Collexis-related php functions @{@%
@< the removejavagarbage function @>
@| @}

\section{Fingerprint files}
\label{sec:fingerprintfiles}

In the original version Collexis was not yet available to obtain the
phrases in the search documents that belong to concepts. Instead, the
phrases and the title of the concept were read from \emph{fingerprint
  files}. The following functions can be used to obtain the
information.

@d php functions @{@%
function concepttitle(\$conceptnum){
  if (\$handle = fopen("m4_fingerprintfiltrunk".\$conceptnum, "rb")) {
    \$rets=rtrim(fgets(\$handle));
    fclose(\$handle);
  } else {
    \$rets="Concept ".\$conceptnum." isternie";
  };
  return \$rets;
}
@| concepttitle @}

\section{Editor}
\label{sec:editor}

Include the tinymce editor in the backdoor program.

@d initialize tinymce @{@%
?>
<script language="javascript" type="text/javascript" src="m4_tinyMCEURL"></script>
<script language="javascript" type="text/javascript">
tinyMCE.init({
    mode : "textareas",
    theme : "advanced",
    plugins : "table,save,advhr,advimage,advlink,emotions,iespell,insertdatetime,preview,zoom,flash,searchreplace,print,contextmenu",
    theme_advanced_buttons1_add_before : "save,separator",
    theme_advanced_buttons1_add : "fontselect,fontsizeselect",
    theme_advanced_buttons2_add : "separator,insertdate,inserttime,preview,zoom,separator,forecolor,backcolor",
    theme_advanced_buttons2_add_before: "cut,copy,paste,separator,search,replace,separator",
    theme_advanced_buttons3_add_before : "tablecontrols,separator",
    theme_advanced_buttons3_add : "emotions,iespell,flash,advhr,separator,print",
    theme_advanced_toolbar_location : "top",
    theme_advanced_toolbar_align : "left",
    theme_advanced_path_location : "bottom",
    plugin_insertdate_dateFormat : "%Y-%m-%d",
    plugin_insertdate_timeFormat : "%H:%M:%S",
    extended_valid_elements : "a[name|href|target|title|onclick],img[class|src|border=0|alt|title|hspace|vspace|width|height|align|onmouseover|onmouseout|name],hr[class|width|size|noshade],font[face|size|color|style],span[class|align|style]",
    external_link_list_url : "example_data/example_link_list.js",
    external_image_list_url : "example_data/example_image_list.js",
    flash_external_list_url : "example_data/example_flash_list.js"
});
</script>
<?php
@| @}


@d place the tinymce editor @{@%
?>
 <form method="post" action="<?php printf("%s",address_with_unmodified_querystring());?>">
 <textarea id="@1" name="@1" rows="15" cols="80"><?php echo @2;?></textarea>
<br />
<input type="submit" name="save" value="Submit" />
@%<input type="reset" name="reset" value="Reset" />
</form>
<?php
@| @}



\chapter{Software structures}
\label{chap:softstruct}

\section{Concept}
\label{sec:concept}

The most important entity in this program is the \qstring{legal
concept}. The legal problem of the user is analysed and split up in a
collection of legal concepts. The legal ontology shows how the legal
concepts are related to each other. The Collexis data-mining software
finds verdicts for which the concepts are relevant. These concepts are
found with the aid of typical phrases and sentences. We use these
sentences to annotate the verdicts. The php class \texttt{Concept}
handles everything related to concepts. We will create an object of
this class for every concept that is relevant in a session.


@o m4_libdir/m4_packagename.concepto.php @{@%
<?php
  require_once("m4_libdir/m4_packagename.ontologyconnect.php");
  @< code of concepto.php @>
?>
@| @}

Load this file.

@d initial php statements @{@%
require_once("m4_libdir/m4_packagename.concepto.php");
@| @}


@d code of concepto.php @{@%
class Concepto {
  @< variables of the Concepto class @>
  @< methods of the Concepto class @>
  @< message system for class @>

}

@| Concepto @}

A \texttt{Concepto} object stores the following information about the
concept:

@d variables of the Concepto class @{@%
var \$uri;              // ID of the concept.
var \$title;            // title of the concept.
var \$explanation;      // text with explanation.
var \$superconcepts;    // array of super-classes.
var \$fingerphrases;    // array of fingerprint phrases.
var \$fingerweights;    // array of fingerprint weights.
var \$relevantverdicts=array(); // array of relevant verdicts.
@| @}

@d methods of the Concepto class @{@%
function uri(){
 return \$this->uri;
}

function title(){
 return \$this->title;
}

function explanation(){
 return \$this->explanation;
}

function verdicts(){
 return \$this->relevantverdicts;
}

function fingerphrases(){
  return \$this->fingerphrases;
}

function fingerweights(){
  return \$this->fingerweights;
}

@| uri title explanation verdicts fingerphrases fingerweights @}

\subsection{Load the concept}
\label{sec:load}

The constructor needs the \textsc{uri} of the concept to set the
object up. Then, it gathers all the information. Currently, instead of
an \textsc{uri}, an old-fashioned fingerprint name can be given instead.

@d methods of the Concepto class @{@%
function __construct(\$uri){
@%  @< pemess @("Concepto; uri: ".\$uri@) @>
  @< construction of the Concepto class @>
}

@| __construct @}


Get and store information from the ontology. Get the phrases in the
search document that belongs to the concept. Get a list of verdicts
for which this verdict is relevant. 

Currently, the ontology is not yet in a good shape and the proper search
documents cannot be found. Therefore, we allow for the old-fashioned
way to use \qstring{fingerprint files} instead.

@d construction of the Concepto class @{@%
\$this->uri=\$uri;
if(preg_match("/^fp/", \$uri)<=0){
  @< check the uri @>
  \$this->uri=\$uri;
  \$this->read_ontology(\$uri);
  \$this->read_phrases();
  \$this->get_LJNs_from_Collexis();
} else {
  \$this->uri=\$uri;
  \$conceptnum=0+preg_replace("/^fp/", "", \$uri);
  \$this->init_with_fingerprint_file(\$uri);
  \$this->get_helptext_from_helpfile(\$conceptnum);
  \$this->get_LJNs_from_list(\$conceptnum);
}
@| @}


There is confusion about whether the namespace should be passed as
\textsc{URI} in the \textsc{url} for this page. If only the title part
is passed, add the prefix.  

@d check the uri @{@%
if(stripos(\$uri, "`#'")===FALSE) \$uri="<m4_defaultnamespace`'".\$uri.">";
@| @}


\subsubsection{Get information from the ontology}
\label{sec:infofromontology}

Once we know the \uri{} of the concept, we can obtain information
about it in the \best{} ontology. The following information can be
obtained:

\begin{enumerate}
\item The title of the concept.
\item Explaining text of the concept.
\item The \uri{} of the concept of which the current concept is a
  descendant (if existent).
\end{enumerate}

@d methods of the Concepto class @{@%
function read_ontology(\$uri){
  \$ontc=new Ontologyconnect();
  @< get the title of the concept @>
  @< get the explanation of the concept @>
  @< get the superior concepts @>
}

@| read_ontology @}


Get the title:

@d get the title of the concept @{@%
list(\$this->title)=\$ontc->get_object_elements( \$uri
                                               , \$ontc->best_preflabel
                                               , "literal"
                                               );
@%\$this->title=\$ontc->get_single_element_from_queryxmlresult(\$response, "literal");
@%if(\$response===FALSE){
@%  \$this->explanation=FALSE;
@%} else {
@%  \$xml=new SimpleXMLElement(\$response);
@%  \$this->title=\$xml->results[0]->result[0]->binding[0]->literal[0];
@%};
@| @}


Get the explanatory text:

@d get the explanation of the concept @{@%
@%\$tempuri="<http://www.owl-ontologies.com/OnrechtmatigeDaad.owl#Aansprakelijkheid_voor_ondergeschikten>";
list(\$this->explanation)=\$ontc->get_object_elements( \$uri
                                                     , \$ontc->rdfs_comment
                                                     , "literal"
                                                     );
@| @}

Get an array with uri's of superclasses:

@d get the superior concepts  @{@%
\$subject=\$uri;
\$predicaat1=\$ontc->rdfs_subclass;
\$predicaat2=\$ontc->best_preflabel;
\$query="select ?x where { ".\$subject." ".\$predicaat1." ?x ";
\$query=\$query." . ?x \$predicaat2 [] . }";
\$response=\$ontc->selectquery(\$query);
if(\$response===FALSE){
  \$this->superconcepts=FALSE;
} else {
  \$xml=new SimpleXMLElement(\$response);
  \$ar=\$xml->results[0]->result[0]->binding[0]->uri;
  for(\$i=0;\$i<count(\$ar);\$i++){
    \$this->superconcepts[\$i]=new Concepto("<".\$ar[\$i].">");
@%    \$this->superconcepts[\$i]->read_ontology("<".\$ar[\$i].">");
@%    \$this->superconcepts[\$i]->read_phrases();
  };
};
@| @}

\subsubsection{Get phrases of the search-document}
\label{sec:getphrases}

The search document is labelled as the title of the
concept. Currently, the search documents are stored as files, but
eventually they must be retrieved from the Collexis data-mining
service. 

@d methods of the Concepto class @{@%
function read_phrases(){
  @< code of read\_phrases function @>
}
@| read_phrases @}


Do the following:
\begin{enumerate}
\item Generate the pathname of the search-document.
\item Try to open a file with this pathname.
\item If successful, read the phrases in an array.
\end{enumerate}

@d code of read\_phrases function @{@%
@< generate pathname of the search-document @>
@< read the search-document @>
@| @}

To generate the path-name, replace in the title of the concept the
spaces by underscore chars, prepend colon's by backslashes and add the pathway.

@d generate pathname of the search-document @{@%
\$pat[0]="/ /"; \$repl[0]="_";
\$pat[1]="/:/"; \$repl[1]="_";
\$sfpath="m4_searchdocdir/".strtolower(preg_replace(\$pat, \$repl, \$this->title));
@| @}


@d read the search-document @{@%
if(is_file(\$sfpath)){
  \$handle=fopen(\$sfpath, "rb");
  \$linenum=0;
  unset(\$this->fingerphrases);
  unset(\$this->fingerweights);
  while(!feof(\$handle)){
    \$line=trim(fgets(\$handle));
    \$ar=explode("\t", \$line);
    \$weight=trim(reset(\$ar));
    \$phrase=trim(next(\$ar));
    if(strlen(\$phrase)>1){
      \$linenum++;
      \$this->fingerweights[\$linenum]=\$weight;
      \$this->fingerphrases[\$linenum]=\$phrase;
@%    \$this->fingerphrases=file(\$sfpath, FILE_IGNORE_NEW_LINES);
    };
  };
  fclose(\$handle);
} else {
  \$this->fingerphrases=FALSE;
};
@| @}


Get information in the old-fashioned way. The argument is a string
that consists of a concatenation of \qstring{fp} and a \emph{concept
  number}, e.g.{} \texttt{fp5}. The title of the concept and the
fingerprint strings can be retrieved from a file with the same name
that resides in directory \verb|m4_fingerprintdir|.

@d methods of the Concepto class @{@%
function init_with_fingerprint_file(\$fpnam){
  if (\$handle = fopen("m4_fingerprintdir/".\$fpnam, "rb")) {
    \$this->title=rtrim(fgets(\$handle));
    @< read the strings and the weights in Concepto @>
    fclose(\$handle);
  } else {
    @< pemess @("Kan fingerprints niet lezen"@) @>
    \$rets="Concept ".\$conceptnum." isternie";
  };

}
@| @}


@d read the strings and the weights in Concepto @{@%
\$this->fingercount=0;
while(!feof(\$handle)){
 \$infracs=explode("\t", rtrim(fgets(\$handle)));
 if(\$infracs[1]!=""){
   \$this->fingercount++;
   \$this->fingerweights[\$this->fingercount]=\$infracs[0];
   \$this->fingerphrases[\$this->fingercount]=\$infracs[1];
 };
};  
@| @}

@d variables of the Concepto class @{@%
var \$fingercount;
@| @}

Get the explanation in the old-fashioned way, from the file
\verb|m4_helpdir/concepthelp|. This file consists of tab-separated
lines in which the first field is the concept number and the second
field is the explanation. If an explanation has been fount, it is
copied to the \verb|explanation| variable. Hence, if this variable has
remained empty, no explanation has been found.

@d methods of the Concepto class @{@%
function get_helptext_from_helpfile(\$conceptnum){
  \$concepthelpfil="m4_helpdir/concepthelp";
  \$this->explanation="";
  if(\$handle=fopen(\$concepthelpfil,  "rb")){
    while(!feof(\$handle)){
      \$linarr = explode("\t", rtrim(fgets(\$handle)));
      if(\$linarr[0]==\$conceptnum){
        \$this->explanation=\$linarr[1];
        break;
      };
    };
  };
}

@| get_helptext_from_helpfile @}


\subsubsection{Get LJN's of relevant verdicts}
\label{sec:getrelevantverdicts}

Get the list of relevant verdicts in the old-fashioned way from a file
in directory \verb|m4_resourcesdir|. 

@d methods of the Concepto class @{@%
function get_LJNs_from_list(\$conceptnum){
  \$filnam="m4_verdictslist.fp".\$conceptnum;
  if(file_exists(\$filnam)){
    \$this->relevantverdicts=file(\$filnam, FILE_IGNORE_NEW_LINES);
  };
}

@| get_LJNs_from_list @}

Get a list of relevant verdicts, but not search documents, from
Collexis. return the number of relevant verdicts found. 

@d methods of the Concepto class @{@%
function get_LJNs_from_Collexis(){
  \$this->relevantverdicts=get_related_document_refs( \$this->seeddoc()
                                                    , \$this->collID()
                                                    );
  \$cnt=count(\$this->relevantverdicts);
  if(\$cnt<=0) return 0;
  \$cnt=0;
  \$ljnpattern="/^[A-Z][A-Z][0-9][0-9][0-9][0-9]/";
  foreach(\$this->relevantverdicts as \$key => \$value){
    if(preg_match(\$ljnpattern, strtoupper(\$value))==0){
@%      @< pemess @("Gooi ".\$value." weg."@) @>
      unset(\$this->relevantverdicts[\$key]);
    } else {
      \$this->relevantverdicts[\$key]=trim(\$value);
      \$cnt++;
@%      @< pemess @("Houd ".\$value." er in."@) @>
    };
  };
  return \$cnt;
}

@| get_LJNs_from_Collexis @}


\subsection{Annotate a text-string}
\label{sec:annotate}

To find out whether e.g.{} a text paragraph is relevant w.r.t.{} the
concept and to annotate the paragraph, search for occurrences of the
fingerprints in it. The method \verb|match| accepts a string and
matches the fingerprint strings with it.


@%\textbf{NOTE:} We have the convention that the offset\index{offset,
@%  convention} of a matching string is the number of the first
@%character, counting from unity.

Store of every match the
following:
\begin{itemize}
\item The offset and the length;
\item The number of the fingerprint string.
\end{itemize}

Furthermore, store the following statistics:

\begin{itemize}
\item The number of single-word strings that match;
\item The number of multiple-word strings that match;
\item The sum of the weights of the matching strings.
\end{itemize}

@d variables of the Concepto class @{@%
var \$matchstring = "";
var \$matchcount = 0;
var \$matchoff;
var \$matchlen;
var \$matchfingnum;
var \$singlewordmatchcount = 0;
var \$multiwordmatchcount = 0;
var \$matchweightssum = 0;
@| @}


@d methods of the Concepto class @{@%
function match(\$s){
  \$this->matchstring=\$s;
  \$this->matchcount=0;
  for(\$i=1;\$i<=\$this->fingercount;\$i++){
    @< match fingerprint string i @>
  };
}

@| match @}

Perform the match. Note that function \verb|stripos| ignores the
difference between uppercase and lowercase and that it considers the
offset of the first character to be zero.

@d match fingerprint string i @{@%
\$singlew=(count(explode(" ", \$this->fingerphrases[\$i]))==1);
\$sl=strlen(\$this->fingerphrases[\$i]);
\$lastoffs=-1;
while((\$lastoffs=stripos(\$s, \$this->fingerphrases[\$i], \$lastoffs+1))){
  \$this->matchcount++;
  \$this->matchoff[\$this->matchcount]=\$lastoffs;
  \$this->matchlen[\$this->matchcount]=\$sl;
  \$this->matchfingnum[\$this->matchcount]=\$i;
  if(\$singlew){
   \$singlewordmatchcount++;
  } else {
   \$multiwordmatchcount++;
  };
  \$this->matchweightssum+=\$this->fingerweights[\$i];
};
@| @}


Report statistical data about the matches:

@d methods of the Concepto class @{@%
function sw_matches(){
  return \$this->singlewordmatchcount;
}

function mw_matches(){
  return \$this->multiwordmatchcount;
}

function matches(){
  return \$this->singlewordmatchcount+\$this->multiwordmatchcount;
}

function matchweight(){
  return \$this->matchweightsum;
}

@| sw_matches mw_matches matches matchweight @}

@%Report matches with Matchingstrings. The following function returns
@%either an empty string or a
@%matching string with the first match of which the offset is larger
@%than the argument.
@%
@%@d methods of the Concepto class @{@%
@%function matchafter(\$offset){
@%  \$matchid=1;
@%  while( (\$matchid<\$this->matchcount) 
@%           && 
@%         (\$this->matchoff[\$matchid]<=\$offset)
@%       ) \$matchid++;
@%  if(\$this->matchoff[\$matchid]>\$offset){
@%    return new Matchingstring
@%               ( \$this->matchoff[\$matchid]
@%               , \$this->matchlen[\$matchid]
@%               , \$this->id
@%               , \$this->fingerweights[\$this->matchfingnum[\$matchid]]
@%               , count(explode(" ", \$this->fingerphrases[\$this->matchfingnum[\$matchid]]))
@%               );
@%  } else {
@%    return "";
@%  };
@%}
@%
@%@| matchafter @}


\subsection{Relevant verdicts}
\label{sec:relevantverdicts}

Test whether the concept is relevant for a given \ljn{}.

@d methods of the Concepto class @{@%
function is_relevant_verdict(\$ljn){
  if(count(\$this->relevantverdicts)==0){
    return FALSE;
  } else {
    return in_array(\$ljn, \$this->relevantverdicts);
  };
}

@| is_relevant_verdict @}


@%\subsection{Test the Concepto class}
@%\label{sec:testConcepto}
@%
@%
@%Test the concept class:
@%\begin{itemize}
@%\item Create an object of the Concept class.
@%\item Fill it with a title, a number and a fingerprint file.
@%\item Match a string.
@%\end{itemize}
@%
@%@o m4_bindir/testconcepto.php @{@%
@%#!/usr/bin/php -f
@%<?php
@%require_once("m4_libdir/m4_packagename.concepto.php");
@%\$con=new Concepto("fp5");
@%\$con->testrap();
@%\$con->match("het vereist verband is omkeringsregel.");
@%\$mat=\$con->matchafter(0);
@%if(\$mat!=""){
@%  printf("Match begint op %d en is %d letters lang.\n", \$mat->offset(), \$mat->length());
@%}
@%@< php functions @>
@%?>
@%@| @}
@%
@%@d make executables executable @{@%
@%	chmod 775 m4_bindir/testconcepto.php
@%@| @}
@%
@%
@%Print a report:
@%
@%@d methods of the Concepto class @{@%
@%function testrap(){
@%  printf("Titel: %s\n\n", \$this->title);
@%  printf("Uitleg:\n %s\n\n", \$this->explanation);
@%  printf("Fingerprint zinnen:\n");
@%  foreach(\$this->fingerphrases as \$linenum => \$line){
@%    printf("  %s\n", \$line);
@%  };
@%  printf("\n");
@%}
@%@| @}
@%
@%
@%Put some fingerprint strings in the object:
@%
@%@d methods of the Concepto class @{@%
@%function put_some_fingerprintstrings_in_it(){
@%   \$this->fingerphrases[1]="aap noot mies";
@%   \$this->fingerphrases[2]="scha-pen";
@%   \$this->fingerphrases[3]="mies";
@%   \$this->fingerweights[1]="80";
@%   \$this->fingerweights[2]="40";
@%   \$this->fingerweights[3]="20";
@%   \$this->fingercount=3;
@%}
@%@| @}

\section{Miscellaneous about concepts}
\label{sec:conceptmiscs}

\subsection{Print a pointer to a single concept}
\label{sec:pointertosingleconcept}

I hope that the magic with \verb|\$sconcept| is not too
confusing. After the initialisation it contains the number of the
active concept. This is used to check whether the concept to be listed
is the active concept. Then \verb|\$sconcept| is made empty and serves
to create a querystring with the current concept number in it.

\label{pointertosingleconcept}%
@d functions of index @{@%
function old_pointer_to_single_concept(\$conceptnum, \$helpobj){
  \$sconceptset=new Conceptset;
  \$active=\$sconceptset->is_active_concept(\$conceptnum);
  if (\$handle = fopen("m4_fingerprintfiltrunk".\$conceptnum, "rb")) {
      \$concepttitle=rtrim(fgets(\$handle));
      \$sconceptset->make_empty();
      \$questr=\$sconceptset->querystring_with_conceptnr(\$conceptnum, "c");
      \$questr=remove_filename_from_querystring(\$questr);
      fclose(\$handle);
      if(\$active){
          \$returnstring=\$concepttitle;
      } else {
        \$returnstring=" <a class=pah ";
        \$returnstring=\$returnstring.\$helpobj->onmouseoverriedel(\$conceptnum);
        \$returnstring=\$returnstring." href=\"m4_webURL`'/index.php?".\$questr."\">";
        \$returnstring=\$returnstring.\$concepttitle;
        \$returnstring=\$returnstring."</a>";
      };
  } else {
     \$returnstring="concept ".\$conceptnum." isterniet.";
  };
  return \$returnstring;
}
@| old_pointer_to_single_concept \$sconceptset @}


\section{Concepts management}
\label{sec:whichconcepts}

When the display program starts, it obtains the \ID's of one or more
concepts that are relevant for the case. One or more of these concepts
can be \emph{active} i.e.{} they are explained and relevant paragraphs
in verdicts are highlighted.

In concept-oriented mode, at most a single concept is active, but in
document-oriented mode, the user may select a set of multiple
\qstring{active} concepts, to be highlighted in a displayed verdict.

@%Probably it is not useful to illuminate a very large
@%quantity of concepts at the same time. The amount of colours needed to
@%illuminate every combination of $n$ concepts is equal to $2^n$. Therefore, we will limit this
@%to m4_maxactiveconcepts \qstring{active} concepts. The set of active concept
@%is passed as argument of the \verb|m4_conceptnumkeyword| in the
@%query-string.

The class \verb|Conceptset| stores the concepts as objects and the set of active concepts in the
current web page. It provides the following methods:

\begin{tabular}{lp{10cm}}
  \texttt{Conceptset()} & Constructor. Reads concept list from the querystring. \\
  \texttt{concept(num)} & Returns Concepto object of concept nr.~\texttt{num}.
                             Note that counting starts from unity, not from zero. \\
  \texttt{active\_concept(num)} & Returns active Concepto object
                          nr.~\texttt{num}. \\
  \texttt{first\_concept()} & Returns the first concept or \texttt{FALSE} if there is none. \\
  \texttt{current\_concept()} & Returns the last requested concept or \texttt{FALSE} if such a concept is not present. \\
  \texttt{next\_concept()} & Returns the next concept or \texttt{FALSE} if there is no next concept. \\
  \texttt{first\_active\_concept()} & Returns the first active concept or \texttt{FALSE} if there is none. \\
  \texttt{current\_active\_concept()} & Returns the last requested active concept or \texttt{FALSE} if such a concept is not present. \\
  \texttt{next\_active\_concept()} & Returns the next active concept or \texttt{FALSE} if there is no next active concept. \\
  \texttt{first\_non\_active\_concept()} & Returns the first non-active concept or \texttt{FALSE} if there is none. \\
  \texttt{current\_non\_active\_concept()} & Returns the last requested non-active concept or \texttt{FALSE} if such a concept is not present. \\
  \texttt{next\_non\_active\_concept()} & Returns the next non-active concept or \texttt{FALSE} if there is no next non-active concept. \\
  \texttt{conceptcount()} & Returns number of stored concepts. \\
  \texttt{nr}           & Returns number of active concepts. \\
  \texttt{arra}         & Returns array with numbers of active concepts \\
  \texttt{querystring\_with\_conceptnr(num)} & 
                  Returns querystring in which concept-number
                  \texttt{num} is made active. This can be pasted in an \textsc{url}. \\
  \texttt{querystring\_without\_conceptnr(num)} &
         Returns querystring with concept-numbers excluding \texttt{num}. \\
  \texttt{is\_active\_concept(num)} &
        Returns whether concept \texttt{num} is an active concept. \\
  \texttt{concept\_seqnum(num)} &
       Returns a sequential number if concept \texttt{num} is active, or returns~0 otherwise. \\
  \texttt{store\_old\_concepts()} & Temporary provision. Stores the old-fashioned ``fp''-style concepts. \\
  \texttt{querystring\_with\_conceptlist()} & Temporary provision. Generates a querystring
                       in which the \ID's of the stored concepts. \\
\end{tabular}

We consider the active concept set a global feature for the whole of
the page in which it is used.

@d php functions @{@%
class Conceptset {
  @< variables of the Conceptset class @>
  @< methods of the Conceptset class @>
}

@| Conceptset @}

Initialise a conceptset. If \textsc{cgi} arguments \verb|conceptn|
(\verb|n| is a number) are present, load these concepts.
@%To indicate
@%that this has been done, set \verb|\$mode| to
@%\verb|sesame|.
Otherwise, if we are in concept-oriented mode, load all
the old-fashioned \verb|fp|-style concepts.
@% and set the mode to \verb|classic|.
Else, if we are in document-oriented mode, load the
concepts from the ``casegroup file''.

@d initial php statements @{@%
global \$conceptset;
\$conceptset=new Conceptset;
@| \$conceptset @}

@d variables of the Conceptset class @{@%
  var \$concepts=array();        // Array of Concepto objects. Counting starts at 1.
  var \$active_concepts=array(); // Array with numbers of the active objects. Counting starts at 1.
  var \$active_concept_count=0;
@| @}


@d methods of the Conceptset class @{@%

function Conceptset(){
  parse_str(\$_SERVER['QUERY_STRING'], \$params);
@%  foreach(\$params as \$key => \$value){  }
@%   @< pemess @("params[".\$key."] = ".\$value<br>"@) @>
  \$this->concepts=NULL;
  \$this->active_concept_count=0;
  \$this->active_concepts=array();
  @< get the concept ids; store in Concepto objects @>
  @< get the numbers of the active objects @>
}

@| Conceptset @}

Get the list of concepts from the \textsc{url} of this page. Most of
the time, the \textsc{uri} of the concept can be found as the value of
\textsc{cgi} parameter \texttt{conceptn}, where \verb|n| is a
number. If no such parameters are present, revert to ``classic'' mode,
the older style, in which the \textsc{id} of the concepts are strings
\verb|fpn| (with \verb|n| a number). 

\textsc{url}, the \textsc{id} of each concept is stored as a parameter
with label \verb|m4_conceptidkeyword`'N|, where \texttt{N} is a
sequence number. The numbers of the active concepts are stored as a
comma-separated list in parameter \texttt{m4_conceptnumkeyword}.

@d get the concept ids; store in Concepto objects @{@%
@< try to find concept URI's from the URL @>
if(\$this->conceptcount()==0){
  if(parameter_value_of('mode')=="c"){
    \$this->store_old_concepts();
  } else {
    if(parameter_value_of('mode')=="d"){
      \$this->store_concepts_from_clusterlist(parameter_value_of('cl'));
@%      @< pemess @("<p>Stored ".\$this->conceptcount()." concepts.</p>"@) @>
    };
  };
}

@| @}


@d try to find concept URI's from the URL  @{@%
\$conceptseqnum=0;
while(TRUE){
  \$conceptseqnum++;
  \$cnam="m4_conceptidkeyword".\$conceptseqnum;
  if(\$params[\$cnam]=="") break;
  \$this->concepts[\$conceptseqnum]=new Concepto(\$params[\$cnam]);
};
@%\$this->mode=((\$conceptseqnum<=1) ? "empty" : "sesame");
@| @}

@%@d variables of the Conceptset class @{@%
@%var \$mode = "empty";
@%@| mode @}

As long as we have to use the old-fashioned \qstring{fp}-style concept
titles, use the following function to load them all.

@d methods of the Conceptset class @{@%
function store_old_concepts(){
  for(\$i=1;\$i<=m4_nrofconcepts;\$i++){
    \$cid="fp".\$i;
    \$this->concepts[\$i]=new Concepto(\$cid);
  };
@%  \$this->mode="classic";
}

@| store_old_concepts @}


When in document-oriented mode no concepts have been passed by the
\textsc{uri}, load them from a \qstring{casegroup} file.

@d methods of the Conceptset class @{@%
function store_concepts_from_clusterlist(\$clusterfilnam){
  if(\$handle=fopen("m4_casegrouplist/".\$clusterfilnam, "rb")){
    \$fpnums= explode(" ", trim(fgets(\$handle))); fclose(\$handle);
    if(count(\$fpnums)>0){
      \$conceptcounter=0;
      foreach(\$fpnums as \$key => \$value){
       \$concepttitle="fp".\$value;
       \$conceptcounter++;
       \$this->concepts[\$conceptcounter]= new Concepto(\$concepttitle);
      };
    };
  };
}

@| store_concepts_from_clusterlist  @}



@d get the numbers of the active objects @{@%
\$s=\$params['m4_conceptnumkeyword'];
if(\$s==""){
  \$this->active_concept_count=0;
  \$this->active_concepts=array();
} else {
  \$this->active_concepts=split(",", \$s);
  \$this->active_concept_count=count(\$this->active_concepts);
};
@| @}


Make a conceptset empty:

@d methods of the Conceptset class @{@%
function make_empty(){
  unset(\$this->concepts);
  \$this->active_concept_count=0;
  \$this->active_concepts=array();
}

@| make_empty @}

Return concept number~\texttt{cnum}:

@d methods of the Conceptset class @{@%
function concept(\$cnum){
  return \$this->concepts[\$cnum];
}

@| concept @}


@d methods of the Conceptset class @{@%
function first_concept(){
  @< return the concept @(reset@) @>
}

@| first_concept @}

@d methods of the Conceptset class @{@%
function current_concept(){
  @< return the concept @(current@) @>
}

@| current_concept @}


@d methods of the Conceptset class @{@%
function next_concept(){
  @< return the concept @(next@) @>
}

@| next_concept @}

@d return the concept @{@%
return ( (@1(\$this->concepts)===FALSE)
       ? FALSE
       : current(\$this->concepts)
       );
@| @}

@d methods of the Conceptset class @{@%
function current_conceptkey(){
  return key(\$this->concepts);
}

@| current_conceptkey @}


@d methods of the Conceptset class @{@%
function active_concept(\$num){
  if(\$this->active_concepts[\$num]==""){
    return FALSE;
  } else {
    return \$this->concepts[\$this->active_concepts[\$num]];
  };
}

@| active_concept @}

@d methods of the Conceptset class @{@%
function first_active_concept(){
  @< return the active concept @(reset@) @>
}

@| first_active_concept @}

@d methods of the Conceptset class @{@%
function current_active_concept(){
  @< return the active concept @(current@) @>
}

@| current_active_concept @}


@d methods of the Conceptset class @{@%
function next_active_concept(){
  @< return the active concept @(next@) @>
}

@| current_active_concept @}

@d return the active concept @{@%
if(!(isset(\$this->active_concepts))) return FALSE;
return ( (@1(\$this->active_concepts)===FALSE)
       ? FALSE
       : \$this->concepts[current(\$this->active_concepts)]
       );
@| @}


@d methods of the Conceptset class @{@%
function current_active_conceptkey(){
  return current(\$this->active_concepts);
}

@| current_active_concept @}



@d methods of the Conceptset class @{@%
function first_nonactive_concept(){
  if(reset(\$this->concepts)===FALSE) return FALSE;
  // Multiple returns.
  while(TRUE){
    if(!in_array(key(\$this->concepts), \$this->active_concepts)){
        return current(\$this->concepts);
    };
    if(next(\$this->concepts)===FALSE) return FALSE;
  };
  return FALSE;
}
@| first_nonactive_concept @}

@d methods of the Conceptset class @{@%
function current_nonactive_concept(){
  return current(\$this->concepts);

}
@| current_nonactive_concept @}


@d methods of the Conceptset class @{@%
function next_nonactive_concept(){
  if(next(\$this->concepts)===FALSE) return FALSE;
  // Multiple returns.
  while(TRUE){
    if(!in_array(key(\$this->concepts), \$this->active_concepts)){
      return current(\$this->concepts);
    };
    if(next(\$this->concepts)===FALSE) return FALSE;
  };
  return FALSE;

}
@| next_nonactive_concept @}




@d methods of the Conceptset class @{@%
function conceptcount(){
  return count(\$this->concepts);
}

@| concept @}




Return the number of active concepts:

@d methods of the Conceptset class  @{@%
function active_concept_count(){
  return count(\$this->active_concepts);
}

@| nr @}

Return an array with active concepts or NULL.

@d methods of the Conceptset class  @{@%
function arra(){
  if($this->active_concept_count==0) return NULL;
  return $this->active_concepts;
}
@| nr @}

@%The following function returns an array with the numbers of the
@%selected concepts.
@%
@%@d php functions  @{@%
@%function get_active_concepts(){
@%  \$s=parameter_value_of('m4_conceptnumkeyword');
@%  if(\$s==""){
@%    return NULL;
@%  };
@%  return split(",", \$s);
@%};
@%@| get_active_concepts @}
@%
@%Return the number of active concepts.
@%
@%@d php functions  @{@%
@%function nr_active_concepts(){
@%  \$s=parameter_value_of('m4_conceptnumkeyword');
@%  if(\$s==""){
@%    return 0;
@%  };
@%  return count(split(",", \$s));
@%};
@%@| nr_active_concepts @}

 
The following function returns a querystring that is derived from the
querystring in the title of the current web page, but into which
concept number \texttt{connum} is listed as active. In
concept-oriented mode the selected concept will the only active
concept (it replaces an existing active concept if that is present).

@d methods of the Conceptset class @{@%
function querystring_with_conceptnr(\$connum, \$dispmode){
  if((\$this->active_concept_count==0) || \$dispmode=="c"){
   \$ar= array(\$connum);
  } else {
  \$ar=\$this->active_concepts;
  insert_value_into_array(\$ar, \$connum);
  sort(\$ar);
  };
  return modified_querystring("m4_conceptnumkeyword", implode(",",\$ar));
}

@| querystring_with_conceptnr @}

The following function returns a querystring that is derived from the
querystring in the title of the current web page, but from which an active
concept number has been removed.

@d methods of the Conceptset class @{@%
function querystring_without_conceptnr(\$connum){
  if(\$this->active_concept_count==0){
  return modified_querystring("m4_conceptnumkeyword", "");
  };
  \$ar=\$this->active_concepts;
  remove_value_from_array(\$ar, \$connum);
  sort(\$ar);
  return modified_querystring("m4_conceptnumkeyword", implode(",",\$ar));
}

@| querystring_without_conceptnr @}

The following boolean function informs whether the number that has
been passed as argument is the number of an active concept.

@d methods of the Conceptset class @{@%
function is_active_concept(\$n){
  if(\$this->active_concept_count==0) return FALSE;
  \$res=FALSE;
  foreach(\$this->active_concepts as \$cn){
    if(\$cn==\$n){
      \$res=TRUE;
      break;
    };
  };
  return \$res;
}

@| @}


The following method provides a sequence number for each active
concept. It returns~0 for a non-active concept.

@d methods of the Conceptset class @{@%
function concept_seqnum(\$n){
  if(\$this->active_concept_count==0) return FALSE;
  sort(\$this->active_concepts);
  \$res=0;
  \$i=0;
  foreach(\$this->active_concepts as \$cn){
    \$i++;
    if(\$cn==\$n){
      \$res=\$i;
      break;
    };
  };
  return \$res;
}
@| concept_seqnum @}

@%Create an object of the conceptset class.
@%
@%@d init code @{@%
@%\$conceptset = new Conceptset;
@%@| \$conceptset  @}




@d methods of the Conceptset class @{@%
function querystring_with_conceptlist(){
  \$quest=\$_SERVER['QUERY_STRING'];
  foreach(\$this->concepts as \$num => \$con){
    \$par="m4_conceptidkeyword".\$num;
    \$val=\$con->uri();
    \$quest=cascmodified_querystring(\$quest, \$par, \$val);
  };
  return \$quest;
}

@| querystring_with_conceptlist @}


\section{External program performs task}
\label{sec:externalpipe}

In at least one case (cf.~section~\ref{sec:collexis}) we want a
sub-task to be performed by an external, non-php program. 


The function \verb|monopipe| sets up a
mono-directional pipe to perform the task in the argument and returns
the output of the process, assuming that the output consists of lines
of text.

@d the monopipe function @{@%
function monopipe(\$task){
  \$handle = popen(\$task, 'r');
  if(feof(\$handle)){
    \$output=FALSE;
  } else {
    \$output=trim(fread(\$handle, 2048));
  };
  while(!feof(\$handle)){
    \$output=\$output.fread(\$handle, 2048);
  };
  pclose(\$handle);
  return \$output;
}

@| monopipe @}

@d Collexis-related php functions @{@%
@< the monopipe function @>
@| @}

\section{Convenient macro's and functions}
\label{sec:convenientmacro's}

@%\subsection{Read a text from a file into a string}
@%\label{sec:readtextfile}
@%
@%The following function reads a text and stores it into a single
@%string.
@%
@%@d the function filetostring @{@%
@%function filetostring(\$filenam){
@% 
@%}
@%
@%@| @}



@%\subsection{Read a text line-by-line}
@%\label{sec:readlinebyline}
@%
@%This subsection contains an M4 macro to read a file line by line. Its
@%arguments are 1) the name of the file to be read; 2) the name of a
@%macro to execute for every line and 3) a message to be printed if the
@%line cannot be opened.

\subsection{Array handling}
\label{sec:array}

Put an element into an array in which the relation between key and
value is not important, and avoid to store duplicates.

@d php functions @{@%
function insert_value_into_array( &\$ar, \$val){
  if(isset(\$ar)){
    foreach(\$ar as \$key => \$v){
      if(\$v==\$val) unset(\$ar[\$key]);
    };
  };
  \$ar[]=\$val;
  return;
}

@| insert_value_into_array @}

Remove an element from such an array if it is present.

@d php functions @{@%
function remove_value_from_array( &\$ar, \$val){
  foreach(\$ar as \$key => \$v){
    if(\$v==\$val) unset(\$ar[\$key]);
  };
  return;
}

@| remove_value_from_array @}

\subsection{Messages in objects}
\label{sec:messages}

Provide a mechanism for debugging messages in objects.

@d message system for class @{@%
var \$messages;
var \$status;

function rmes(){
  \$ret=\$this->messages;
  \$this->messages="";
  return \$ret;
}

function ames(\$s){
  \$this->messages=\$this->messages.\$s;
  return \$ret;
}

function reset_status(){
  \$this->status=TRUE;
}

function set_error(){
  \$this->status=FALSE;
}

function object_status(){
  return \$this->status;
}

@| rmes ames reset_status set_error object_status @}


\subsection{Miscellaneous}
\label{sec:miscfuncs}

Determine whether the value of a parameter (\verb|\$para|) is between two given
variables (\verb|\$lower| resp.\ \verb|upper|).

@d php functions @{@%
function is_in_range(\$lower, \$para, \$upper){
  return (  (\$lower<=\$para)  &&  (\$para<=\$upper ) );
}
@| is_in_range @}


Print debug messages with the following macro. In this way these
messages can easily be detected and removed in the source code.

Debug messages:
@d pemess @{@%
printf("Message: %s\n", @1);
@| @}


\section{Ajax}
\label{chap:ajax}

To make the pages more responsive on user interactions, we use
\href{http://en.wikipedia.org/wiki/AJAX}{Ajax} (Asynchonous Javascript
and \xml{}). We use the \php{} \href{http://xajaxproject.org/}{xajax} module.


\subsection{Ajax initialisation}
\label{sec:ajaxinit}

Initialize xajax at the top of the script:

@d initial php statements @{@%
@< initialize xajax @>
@| @}


To initialise xajax, load its php library and initialise an
\verb|xajax| object.

@d initialize xajax @{@%
require('xajax/xajax.inc.php');
\$xajax = new xajax(); 
@| \$xajax @}

Create functions that make ajax do what is has to do and register
them.

@d  initialize xajax @{@%
@< php xajax functions @>
@< register xajax functions @>
@| @}

Process initial requests.

@d initialize xajax @{@%
\$xajax->processRequests();
@| processRequests @}

Xajax has to create javascripts in the header of the \textsc{html}
page.

@d php statements in the header of index @{@%
\$xajax->printJavascript('/xajax');
@%@< xajax statements in the header @>
@%@< Javascripts in the header @>
@| printJavascript @}

@d php statements in the header of backdoordir/index @{@%
\$xajax->printJavascript('/xajax');
@%@< initialize tinymce @>
@%@< xajax statements in the header @>
@%@< Javascripts in the header @>
@| @}

@%@d xajax statements in the header @{@%
@%@| printJavascript @}


@%\chapter{The display program}
@%\label{sec:methods}



@%\section{Programs and program flow.}
@%\label{sec:programs}
@%
@%The \qstring{Programs} are in fact two \textsc{php} files that are processed
@%by the \textsc{http} server (i.c.{} Apache) on request of remote
@%browsers. One of the programs serves to actually present the verdicts
@%to clients and the other program is a \qstring{back-door} that can be used
@%by maintainers to edit help-texts.
@%
@%
@%
@%The program texts of the two programs are similar. 
@%The \qstring{meat} part of the page, that will be displayed, is determined
@%by the function \verb|content()|. Most of the other stuff creates a
@%\textsc{html} page, loads javascripts and defines \textsc{php}
@%functions.
@%


@%The initial \php{} statements:
@%
@%@d initial php statements @{@%
@%@< initialize xajax @>
@%@< definities @>
@%@< init code @>
@%@| @}



@%  chooses to modify a concept helptext, a
@%list of concepts is presented. Otherwise 
@%
@%\begin{itemize}
@%\item Start with the \verb|verdictslist|
@%  (section~\ref{sec:demoresources}) and the two concepts (files
@%  \verb|testconcept.conc| and \verb|GevaarVoorPersonenOfZaken.conc|.
@%\item Show the list of files and the names of the concepts in the
@%  browser. The user may select a document (and a concept).
@%\item Pre-process the document:
@%  \begin{itemize}
@%  \item Identify the beginnings and end-points sentences and
@%    paragraphs (\qstring{sentence splitter})
@%  \item Split up the document as a list of tokens.
@%  \item Stem the word-types in the document.
@%  \end{itemize}
@%\item Identify words and phrases that are listed in the search document.
@%\item Apply certain heuristic rules to tag some of the words
@%  and phrases and associate them with words and phrases in the search document.
@%\item Present the document.
@%\end{itemize}

@%This results in a collection of documents in which relevant terms and
@%phrases have been tagged. This collection is presented to a user as
@%follows:

%The program displays a list with the names (and some features?) of the
%documents. The list is sorted to decreasing rank. When the user clicks
%on one of the documents, its contents are presented in a text window.
%A second window contains the terms and phrases of the \qstring{search
%document}. When the user clicks on one of the terms or phrases, the
%sentences in the document that are associated with it will be
%highlighted (displayed in a special colour), and the word or phrase
%itself will be highlighted with another colour.


@%\subsection{Communication between pages}
@%\label{sec:communication}
@%
@%Most of the time the user interacts with the program by clicking on a
@%\verb|<a>| tag with as target the address of page itself, followed by
@%a query-string that contains parameters that tell the program what to
@%do.
@%
@%In this application we use the following parameters:




@%\section{Provide help}
@%\label{sec:help}

@%This section provides the following:
@%\begin{description}
@%\item[General Help Button] on the navigation bar
@%  (section~\ref{sec:technicalhelp}).
@%\item[Helptext class] to manage help-texts that reside in files (section~\ref{sec:helptextclass}).
@%\item[Concepthelptext:] a subclass to manage help-texts for concepts (section~\ref{sec:concepthelp}.
@%\item[Support for help of legalese] Section~\ref{sec:explainingtexts}
@%\end{description}

@%\section{Concepts and fingerprints}
@%\label{sec:conceptsandfingerprints}
@%
@%
@%The class \verb|Concept| stores everything about a concept.
@%
@%@d php functions @{@%
@%class Concept{
@%  @< variables of the Concept class @>
@%
@%  function __construct(){
@%   @< construction of the Concept class @>
@%  }
@%
@%  @< methods of the Concept class @>
@%}
@%@| Concept @}
@%
@%A concept has at least a title. Furthermore, provide an
@%identification.
@%
@%@d variables of the Concept class @{@%
@%  var \$title = "";
@%  var \$id = 0;
@%@| @}
@%
@%Provide/retrieve the title and the id:
@%
@%@d methods of the Concept class  @{@%
@%function input_title(\$title){
@%  \$this->title=\$title;
@%}
@%
@%function input_id(\$id){
@%  \$this->id=\$id;
@%}
@%
@%function title(){
@% return \$this->title;
@%}
@%
@%
@%function id(){
@% return \$this->id;
@%}
@%
@%@| @}
@%
@%A \verb|concept| object is to contain the textstrings of the
@%fingerprints. Currently, the fingerprints are stored in files. In future, they
@%will be retrieved from the ontology.
@%
@%@d variables of the Concept class @{@%
@%var \$fingerphrases;
@%var \$fingerweights;
@%var \$fingercount = 0;
@%@| @}
@%
@%As long as we use the fingerprint files (not yet the fingerprints
@%supplied by the ontology), initialise the concept with the following
@%function. Pass the concept number to it.
@%
@%@d methods of the Concept class @{@%
@%function init_with_fingerprint_file(\$conceptnum){
@%  \$this->id=\$conceptnum;
@%  if (\$handle = fopen("m4_fingerprintfiltrunk".\$conceptnum, "rb")) {
@%    \$title=rtrim(fgets(\$handle));
@%    @< read the strings and the weights @>
@%    fclose(\$handle);
@%  } else {
@%    \$rets="Concept ".\$conceptnum." isternie";
@%  };
@%  
@%}
@%@| @}
@%
@%
@%@d read the strings and the weights @{@%
@%\$this->fingercount=0;
@%while(!feof(\$handle)){
@% \$infracs=explode("\t", rtrim(fgets(\$handle)));
@% if(\$infracs[1]!=""){
@%   \$this->fingercount++;
@%   \$this->fingerweights[\$this->fingercount]=\$infracs[0];
@%   \$this->fingerphrases[\$this->fingercount]=\$infracs[1];
@% };
@%};  
@%@| @}
@%
@%\subsection{Find fingerprint strings in a given string}
@%\label{sec:matching}
@%
@%To find out whether e.g.{} a text paragraph is relevant w.r.t.{} the
@%concept and to annotate the paragraph, search for occurrences of the
@%fingerprints in it. The method \verb|match| accepts a string and
@%matches the fingerprint strings with it.
@%
@%
@%@%\textbf{NOTE:} We have the convention that the offset\index{offset,
@%@%  convention} of a matching string is the number of the first
@%@%character, counting from unity.
@%
@%Store of every match the
@%following:
@%\begin{itemize}
@%\item The offset and the length;
@%\item The number of the fingerprint string.
@%\end{itemize}
@%
@%Furthermore, store the following statistics:
@%
@%\begin{itemize}
@%\item The number of single-word strings that match;
@%\item The number of multiple-word strings that match;
@%\item The sum of the weights of the matching strings.
@%\end{itemize}
@%
@%@d variables of the Concept class @{@%
@%var \$matchstring = "";
@%var \$matchcount = 0;
@%var \$matchoff;
@%var \$matchlen;
@%var \$matchfingnum;
@%var \$singlewordmatchcount = 0;
@%var \$multiwordmatchcount = 0;
@%var \$matchweightssum = 0;
@%@| @}
@%
@%
@%@d methods of the Concept class @{@%
@%function match(\$s){
@%  \$this->matchstring=\$s;
@%  \$this->matchcount=0;
@%  for(\$i=1;\$i<=\$this->fingercount;\$i++){
@%    @< match fingerprint string i @>
@%  };
@%}
@%
@%@| @}
@%
@%Perform the match. Note that function \verb|stripos| ignores the
@%difference between uppercase and lowercase and that it considers the
@%offset of the first character to be zero.
@%
@%@d match fingerprint string i @{@%
@%\$singlew=(count(explode(" ", \$this->fingerphrases[\$i]))==1);
@%\$sl=strlen(\$this->fingerphrases[\$i]);
@%\$lastoffs=-1;
@%while((\$lastoffs=stripos(\$s, \$this->fingerphrases[\$i], \$lastoffs+1))){
@%  \$this->matchcount++;
@%  \$this->matchoff[\$this->matchcount]=\$lastoffs;
@%  \$this->matchlen[\$this->matchcount]=\$sl;
@%  \$this->matchfingnum[\$this->matchcount]=\$i;
@%  if(\$singlew){
@%   \$singlewordmatchcount++;
@%  } else {
@%   \$multiwordmatchcount++;
@%  };
@%  \$this->matchweightssum+=\$this->fingerweights[\$i];
@%};
@%@| @}
@%
@%
@%Report statistical data about the matches:
@%
@%@d methods of the Concept class @{@%
@%function sw_matches(){
@%  return \$this->singlewordmatchcount;
@%}
@%
@%function mw_matches(){
@%  return \$this->multiwordmatchcount;
@%}
@%
@%function matches(){
@%  return \$this->singlewordmatchcount+\$this->multiwordmatchcount;
@%}
@%
@%function matchweight(){
@%  return \$this->matchweightsum;
@%}
@%
@%@| @}
@%
@%Report matches with Matchingstrings. The following function returns
@%either an empty string or a
@%matching string with the first match of which the offset is larger
@%than the argument.
@%
@%@d methods of the Concept class @{@%
@%function matchafter(\$offset){
@%  \$matchid=1;
@%  while( (\$matchid<\$this->matchcount) 
@%           && 
@%         (\$this->matchoff[\$matchid]<=\$offset)
@%       ) \$matchid++;
@%  if(\$this->matchoff[\$matchid]>\$offset){
@%    return new Matchingstring
@%               ( \$this->matchoff[\$matchid]
@%               , \$this->matchlen[\$matchid]
@%               , \$this->id
@%               , \$this->fingerweights[\$this->matchfingnum[\$matchid]]
@%               , count(explode(" ", \$this->fingerphrases[\$this->matchfingnum[\$matchid]]))
@%               );
@%  } else {
@%    return "";
@%  };
@%}
@%
@%@| @}
@%
@%
@%Test the concept class:
@%\begin{itemize}
@%\item Create an object of the Concept class.
@%\item Fill it with a title, a number and a fingerprint file.
@%\item Match a string.
@%\end{itemize}
@%
@%@o m4_bindir/testconcept.php @{@%
@%#!/usr/bin/php -f
@%<?php
@%\$con=new Concept();
@%\$con->input_title("Title of the concept");
@%\$con->input_id(1);
@%\$con->put_some_fingerprintstrings_in_it();
@%\$con->match("In deze zin staat aap noot mies scha-pen.");
@%\$mat=\$con->matchafter(0);
@%if(\$mat!=""){
@%  printf("Match begint op %d en is %d letters lang.\n", \$mat->offset(), \$mat->length());
@%}
@%@< php functions @>
@%?>
@%@| @}
@%
@%@d make executables executable @{@%
@%	chmod 775 m4_bindir/testconcept.php
@%@| @}
@%
@%
@%
@%Put some fingerprint strings in the object:
@%
@%@d methods of the Concept class @{@%
@%function put_some_fingerprintstrings_in_it(){
@%   \$this->fingerphrases[1]="aap noot mies";
@%   \$this->fingerphrases[2]="scha-pen";
@%   \$this->fingerphrases[3]="mies";
@%   \$this->fingerweights[1]="80";
@%   \$this->fingerweights[2]="40";
@%   \$this->fingerweights[3]="20";
@%   \$this->fingercount=3;
@%}
@%@| @}
@%


@%\section{Read a fingerprint file}
@%\label{sec:readfingerprint}
@%
@%\subsection{The title of a concept}
@%\label{sec:concepttitle}
@%
@%The following function returns a string with the title of a concept.
@%
@%@d php functions @{@%
@%function concepttitle(\$conceptnum){
@%  if (\$handle = fopen("m4_fingerprintfiltrunk".\$conceptnum, "rb")) {
@%    \$rets=rtrim(fgets(\$handle));
@%    fclose(\$handle);
@%  } else {
@%    \$rets="Concept ".\$conceptnum." isternie";
@%  };
@%  return \$rets;
@%}
@%@| concepttitle @}

@%\section{The windows to be displayed}
@%\label{sec:windows}

@%\section{Back-door to edit help-texts}
@%\label{sec:backdoor}
@%
@%Provide an easy way to edit helptexts and add help texts for legalese
@%words. To this end, we provide a separate web-page in a directory with
@%password protection. The protection mechanism is outside of the scope
@%of this manuscript.
@%
@%
@%\subsubsection{Include editor}
@%\label{sec:editor}
@%
@%Include Web editor \verb|tinymce| into the page.
@%



\chapter{Test programs}
\label{chap:testprogs}

\section{Test Collexis interface}
\label{sec:testcollexisint}

Test the Java \qstring{Search} program.

When the following parameters are set in Makefile, the Makefile runs
the Search program:

@d parameters in Makefile @{@%
JavaMainClass= m4_collexispackagename.Search
RunParameters= "fp2 m4_elisabethtweecollexionid"
@| @}

Another way to run it, is with the following \php{} script:

The script sets up a pipe with the Java virtual machine and reads the outcome.

@o m4_bindir/getverdicts.php @{@%
#!/usr/bin/php -f
<?php
  \$seeddoc=(count(\$argv)<=1 ? "fp10" : \$argv[1]);
  \$collID=(count(\$argv)<=2 ? "m4_elisabethdriecollexionid" : \$argv[2]);
  \$docar=get_related_document_refs(\$seeddoc, \$collID);
  printf("Documents related to %s\n", \$seeddoc);
  for(\$i=0;\$i<count(\$docar);\$i++){
     printf("%s\n",\$docar[\$i]);
  };
@< php functions @>
?>
@| @}

@d make executables executable @{@%
@< executable @(m4_bindir/getverdicts.php@) @>
@| @}


\begin{figure}[hbtp]
  \centering
\begin{verbatim}
- Unable to find required classes (javax.activation.DataHandler and javax.mail.internet.MimeMultipart). Attachment support is disabled.
<?xml version="1.0" encoding="ISO-8859-1"?>
<ClassificationTree version="1.0">
  <ObjectSet>
    <!-- 3 object found -->
    <Object ID="fp10">
      <Location>http://www.rechtspraak.nl/ljn.asp?ljn=fp10</Location>
      <Name> , </Name>
    </Object>
    <Object ID="fp14">
      <Location>http://www.rechtspraak.nl/ljn.asp?ljn=fp14</Location>
      <Name> , </Name>
    </Object>
    <Object ID="AI0349">
      <Location>http://www.rechtspraak.nl/ljn.asp?ljn=AI0349</Location>
      <Name>Gerechtshof  18-04-2003, 00/101</Name>
    </Object>
  </ObjectSet>
  <ClassificationSet>
    <Classification ID="fp10">
      <Name>fp10</Name>
      <Objects objectIDs="fp10 fp14 AI0349 "/>
    </Classification>
  </ClassificationSet>
</ClassificationTree>
\end{verbatim}
  \caption{Example output of Search.java}
  \label{fig:searchoutput}
\end{figure}

\section{Test the Concepto class and the ontology connector}
\label{sec:textconcepto}

The web page \verb|m4_demowebpage| prints the details of a concept and of superior
concepts. To do this, add a method to the \verb|Concepto| class to
generate html code.

@d methods of the Concepto class @{@%
function demo_html_code(\$level){
  if(\$level>0){
    printf("<table><tr><td> %d </td><td>\n", \$level);
  };
  printf("<h2>Titel: %s</h2>\n", \$this->title());
  printf("<h2>Uitleg:</h2>\n%s\n\n", \$this->explanation());
  printf("<h2>Zoek-document inhoud:</h2>\n");
  if(\$this->fingerphrases===FALSE){
    printf("Niet beschikbaar of niet leesbaar\n");
  } else {
    printf("<dl>\n");
    foreach(\$this->fingerphrases as \$line_num => \$line) {
      printf("<dt>%d</dt><dd>%3d: %s</dd>\n"
            , \$line_num
            , \$this->fingerweights[\$line_num]
            , htmlspecialchars(\$line)
            );
    };
    printf("</dl>\n");
  };
  printf("<h2>Relevante documenten:</h2>\n");
  printf("<p>Seed doc: %s</p>\n", \$this->seeddoc());
@%  \$docar=get_related_document_refs(\$this->seeddoc(), \$this->collID());
@%  for(\$i=0;\$i<count(\$docar);\$i++){
@%     printf("<p>%s</p>\n",\$docar[\$i]);
@%  };
  foreach(\$this->relevantverdicts as \$key=>\$value){
     printf("<p><a href=\"http://www.rechtspraak.nl/ljn.asp?ljn=%s\">%s</a></p>\n"
           , \$value
           , \$value
           );
  };
  if(\$this->superconcepts!=""){
  for(\$i=0;\$i<count(\$this->superconcepts);\$i++){
  printf("<h1>Superieure concepten:</h1>\n");
  \$this->superconcepts[\$i]->demo_html_code(\$level+1);
    };
  };
  if(\$level>0){
    printf("<td></tr></table>\n");
  };
}

@| demo_html_code @}

@d methods of the Concepto class @{@%
function seeddoc(){
  if(preg_match("/^fp/", \$this->uri)>0) return \$this->uri;
  \$pattern[0]="/:/";
  \$replacement[0]=" ";
  return preg_replace(\$pattern, \$replacement, \$this->title).".txt";
@%  return \$this->title.".txt";
}

function collID(){
  if(preg_match("/^fp/", \$this->uri)>0){
    return "m4_elisabethdriecollexionid";
  } else {
    return "m4_tweenulnulachtcollexionid";
  };
}

@| seeddoc collID @}



@o m4_demowebpage @{@%
<!--- m4_demowebpage --->
<!--- m4_header --->
<html>
<head>
</head>
<body>
<?php
  require_once "m4_libdir/m4_packagename.concepto.php";
  \$default_concepturl="Aansprakelijkheid_voor_ondergeschikten";
  \$params=array();
  parse_str(\$_SERVER['QUERY_STRING'], \$params);
  if(count(\$params)==0){
    display_url(\$default_concepturl);
  } else {
    foreach(\$params as \$key => \$value){
      display_url(\$key);
    };
  };

function display_url(\$uri){
@%  @< pemess @("Uri: ".\$uri."<br>"@) @>
@%  \$concept_url="<http://www.owl-ontologies.com/OnrechtmatigeDaad.owl#Aansprakelijkheid_voor_ondergeschikten>";
  \$conco=new Concepto(\$uri);
@%\$conco->read_ontology(\$concept_url);
@%\$conco->read_phrases();
  printf("<h1>Concept in BEST ontologie<h1>\n");
  printf("<h2>uri: %s<h2>\n", unhook_uri(\$conco->uri));
  \$conco->demo_html_code(0);
}

function unhook_uri(\$uri){
  \$pat[0]="/\</";
  \$rep[0]="&#60";
  \$pat[1]="/\>/";
  \$rep[1]="&#62";
  return preg_replace(\$pat, \$rep, \$uri) ;
}

@< Collexis-related php functions @>

?>
</body
</html>
@| @}



\appendix

\chapter{How to read and translate this document}
\label{chap:translatedoc}

This document is an example of \emph{literate
  programming}~\cite{Knuth:1983:LP}. It contains the code of all sorts
of scripts and programs, combined with explaining texts. In this
document the literate programming tool \texttt{nuweb} is used, that is
currently available from sourceforge
(URL:\url{nuweb.sourceforge.net}). The advantages of Nuweb are, that
it can be used for every programming language and scripting language, that
it can contain multiple program sources and that it is very simple.

\section{Read this document}
\label{sec:read}

The document contains \emph{code scraps} that are collected into
output files. An output file (e.g. \texttt{output.fil}) shows up in the text as follows:

\begin{alltt}
"output.fil" \textrm{4a \(\equiv\)}
      # output.fil
      \textrm{\(<\) a macro 4b \(>\)}
      \textrm{\(<\) another macro 4c \(>\)}
      \(\diamond\)

\end{alltt}

The above construction contains text for the file. It is labelled with
a code (in this case 4a)  The constructions between the \(<\) and
\(>\) brackets are macro's, placeholders for texts that can be found
in other places of the document. The test for a macro is found in
conctructions that look like:

\begin{alltt}
\textrm{\(<\) a macro 4b \(>\) \(\equiv\)}
     This is a scrap of code inside the macro.
     It is concatenated with other scraps inside the
     macro. The concatenated scraps replace
     the invocation of the macro.

{\footnotesize\textrm Macro defined by 4b, 87e}
{\footnotesize\textrm Macro referenced in 4a}
\end{alltt}

Macro's can be defined on different places. They can contain other macro´s.

\begin{alltt}
\textrm{\(<\) a scrap 87e \(>\) \(\equiv\)}
     This is another scrap in the macro. It is
     concatenated to the text of scrap 4b.
     This scrap contains another macro:
     \textrm{\(<\) another macro 45b \(>\)}

{\footnotesize\textrm Macro defined by 4b, 87e}
{\footnotesize\textrm Macro referenced in 4a}
\end{alltt}


\section{Process the document}
\label{sec:processing}

\subsection{Overview}
\label{sec:overview}

The raw document is named
\verb|a_`'m4_progname`'.w|. Figure~\ref{fig:fileschema}
\begin{figure}[hbtp]
  \centering
  \includegraphics{fileschema.fig}
  \caption{Translation of the raw code of this document into
    printable/viewable documents and into program sources. The figure
    shows the pathways and the main files involved.}
  \label{fig:fileschema}
\end{figure}
 shows pathways to
translate it into printable/viewable documents and to extract the
program sources. Table~\ref{tab:transtools}
\begin{table}[hbtp]
  \centering
  \begin{tabular}{lll}
    \textbf{Tool} & \textbf{Source} & \textbf{Description} \\
    gawk  & \url{www.gnu.org/software/gawk/}& text-processing scripting language \\
    M4    & \url{www.gnu.org/software/m4/}& Gnu macro processor \\
    nuweb & \url{nuweb.sourceforge.net} & Literate programming tool \\
    tex   & \url{www.ctan.org} & Typesetting system \\
    tex4ht & \url{www.ctan.org} & Convert \TeX{} documents into \texttt{xml}/\texttt{html}
  \end{tabular}
  \caption{Tools to translate this document into readable code and to
    extract the program sources}
  \label{tab:transtools}
\end{table}
lists the tools that are
needed for a translation. Most of the tools (except Nuweb) are available on a
well-equipped Linux system.


\subsection{Directories and files}
\label{sec:directorystructure}

This documents generates a bunch of files, scattered over multiple
directories. The main part of the development of this project takes
place in the directory in which the source of this document is placed,
\texttt{m4_nuwebdir}. It contains the Makefile of this project and the
files to typeset this document. The document can also be typeset as
\textsc{html}, in a separate directory, accesible for the web server.

@d parameters in Makefile @{@%
DevHome= m4_devhome
NuwebHome= m4_nuwebdir
NuwebHtmlDir = m4_htmldocdir
@| DevHome NuwebHome @}

The project uses multiple programming languages. The Java part is
developed in its own directory structure, with sub-directories for the
java-sources, for the class files (\texttt{obj}) and for the jar files
(\texttt{lib}). Other binaries go into the \texttt{BinDir} directory.

The \texttt{lib} dir is also to contain include files with php classes.

@d parameters in Makefile @{@%
BinDir = m4_bindir
PhpDir = m4_phpdir
DevRoot = m4_devroot
SourceDir = \$(DevRoot)/src
TargetDir = \$(DevRoot)/obj
LibDir =  \$(DevRoot)/lib
@| @}

The Java sources and objects are organised in packages. The Java
source files and class files are located in subdirectories that reflect the package name.
Currently we have only
one single package.

@d parameters in Makefile  @{@%
Packages= m4_collexispackagename
PackageDirs= m4_collexispackagedir
@%JavaCollexisPackageName = m4_packagename
@%CollexisPackageSourceDir = \$(SourceDir)/m4_collexispackagedir
@%CollexisPackageTargetDir = \$(TargetDir)/m4_collexispackagedir
@| Packages PackageDirs @}

The main part of this project is a web-interface with users. This is
located in a separate directory, accessible by the web browser:

@d parameters in Makefile @{@%
WebDir= m4_webdir
@| WebDir @}




Generate the directories if they do not yet exist:
@d expliciete make regels @{@%
@< make-directory target @(NuwebHtmlDir@) @>
@%@< make-directory target @(CollexisPackageSourceDir@) @>
@%@< make-directory target @(CollexisPackageTargetDir@) @>
@< make-directory target @(LibDir@) @>
@< make-directory target @(BinDir@) @>
@< make-directory target @(PhpDir@) @>
@| @}

Make the java source directories and target directories beforehand:

@d parameters in Makefile @{@%
JavaSourcePaths= \$(patsubst %,\$(SourceDir)/%,\$(PackageDirs))
JavaDestPaths= \$(patsubst %,\$(TargetDir)/%,\$(PackageDirs))
@| @}
	

@d expliciete make regels @{@%
javasourcedirs : m4_progname.w
	\$(Echo) "mkdir: " \$(JavaSourcePaths)
	\$(MakeDir) \$(JavaSourcePaths)
	touch javasourcedirs

javadestdirs :
	\$(MakeDir) \$(JavaDestPaths)
	touch javadestdirs

@| @}


The nuweb source generates java files, that must be compiled into
class files, that must be stored in a jar. It is possible, that
external class files are needed for the compilation and
execution. Create Makefile symbols for the lists of the java files,
the list of class files and the \qstring{ClassPath}, the jar file and the
name of the java-file that contains the \qstring{Main} method.

We start with a list of the paths to java filenames  from the
\textsc{src} directory.

@d parameters in Makefile @{@%
JavaFiles = \
  @< add java source filename @>

@| @}

Generate a list of the class files into which the java-files compile:

@d parameters in Makefile @{@%
JavaClassFiles = \$(JavaFiles:%.java=  %.class)
@| @}


Generate lists with the full paths to the java files and the class
paths:

@d parameters in Makefile @{@%
JavaFullPaths = \$(JavaFiles:%.java= \$(SourceDir)/%.java)
JavaClassFullPaths = \$(JavaClassFiles:%.class= \$(TargetDir)/%.class)
@| @}


@%We need a list of names of class-files within the package directorie,
@%because that is how they will be stored in the jar file, and we will
@%need a list of full paths of the class-files, because that is the way
@%that they will be stored in the target directory. Generate both lists
@%from the \verb|JavaFile| symbol.
@%
@%@d parameters in Makefile @{@%
@%@%JavaClassFiles = \$(JavaFiles:%.java=  \$(PackageTargetDir)/%.class)
@%JavaClassFiles = \$(JavaFiles:%.java=  %.class)
@%@%JavaClassFilesRel = \$(JavaFiles:%.java=  m4_packagedir/%.class)
@%@| @}

The \verb|ClassPath| list is a concatenation of paths to java libs,
paths to class files that are external to this project and the target
directory:

@d parameters in Makefile @{@%
ClassPath = \$(JavasetLibs):\$(ExternalClasses):\$(TargetDir)
ExternalClasses = @< ExternalClasses @>
@| @}




The name of the jar is equal to the packagename without the dots:

@d parameters in Makefile @{@%
JarFile = \$(LibDir)/m4_packagejar.jar
@| JarFile @}



\subsection{The Makefile}
\label{sec:MakeFile}

This chapter assembles the Makefile for this project.

@o Makefile -t @{@%
@< default target @>

@< parameters in Makefile @> 
@< impliciete make regels @>
@< expliciete make regels @>
@< make targets @>

@| @}

The default target of make is \verb|all|.

@d  default target @{@%
all : @< all targets @>
.PHONY : all

@|PHONY all @}

One of the targets is certainly the \textsc{pdf} version of this
document.

@d all targets @{m4_progname.pdf@}

We use many suffixes that were not known by the C-programmers who
constructed the \texttt{make} utility. Add these suffixes to the list.

@d parameters in Makefile @{@%
.SUFFIXES: .pdf .w .tex .html .aux .log .php

@| SUFFIXES @}

The following macro creates a directory if it does not yet exist:

@d make-directory target @{@%
\$(@1) :
	\$(MakeDir) \$(@1)

@| @}



\subsection{Tools and options}
\label{sec:tools}

Select the tools to perform the compilation and to do other things
like creating directories or viewing/printing documentation:

@d parameters in Makefile @{@%
Echo                   = @@echo
Copy                   = cp
MakeDir                = mkdir -p
Delete                 = rm -fr
WordCount              = wc
List                   = cat
Print                  = lpr
DocumentViewer         = xpdf
@| @}

Set options and other useful things:

@d parameters in Makefile @{@%
MakeOptions            = -k -s
WordCountOptions       = --lines
Empty                  =
Space                  = $(Empty) $(Empty)
@| @}


\subsection{Java compilation and execution}
\label{sec:compile}

Choose the right Java compiler and utilities:

@d parameters in Makefile @{@%
JAVA_HOME = m4_javahome
JavaCompiler           = \$(JAVA_HOME)/bin/javac
JavaArchiver           = \$(JAVA_HOME)/bin/jar
JarSigner              = \$(JAVA_HOME)/bin/jarsigner
JavadocGenerator       = \$(JAVA_HOME)/bin/javadoc
JniCompiler            = \$(JAVA_HOME)/bin/javah
RmiCompiler            = \$(JAVA_HOME)/bin/rmic
JavaVM                 = \$(JAVA_HOME)/bin/java
JRE                    = \$(JAVA_HOME)/jre/lib/rt.jar
JavasetLibs            = \$(JRE)
@| @}

@%Write parameters in the run-script:
@%@d write runscript parameters @{@%
@%@< runscript line @(JAVAHOME=\$(JAVA_HOME)@) @>
@%@< runscript line @(JAVAVM=\$(JavaVM)@) @>
@%@< runscript line @(JRE=\$(JRE)@) @>
@%@< runscript line @(JAVASETLIBS=\$(JavasetLibs)@) @>
@%@| @}


@%@d parameters in run-script @{@%
@%JAVAHOME=m4_javahome
@%JavaVM=\$JAVAHOME/bin/java
@%@| @}


Options for the java compiler and the virtual machine. We must/may specify:
\begin{description}
\item[JavaCompilerOptions:] Option for the virtual machine.
\item[JavaRunOptions:] Option for the virtual machine.
\item[JavaMainClass:] The class that contains \qstring{Main} method.
\item[RunParameters:] Optional parameters for the application.
\end{description}


@d parameters in Makefile @{@%
JavaRunOptions = -classpath \$(ClassPath)

JavaCompilerOptions    = -d \$(TargetDir) -classpath \$(ClassPath) \
			 -sourcepath \$(SourceDir) -deprecation
@| @}

@d parameters in Makefile @{@%
JavaCompile = \$(JavaCompiler) \$(JavaCompilerOptions)
JavaRun = \$(JavaVM) \$(JavaRunOptions) \$(JavaMainClass) \$(RunParameters)

@| @}

@%@d write runscript parameters @{@%
@%@< runscript line @(JAVARUNOPTIONS=\"\$(JavaRunOptions)\"@) @>
@%@< runscript line @(JAVAMAINCLASS=\"\$(JavaMainClass)\"@) @>
@%@< runscript line @(RUNPARAMETERS=\"\$(RunParameters)\"@) @>
@%@< runscript line @(JAVARUN=\"\`'\$\$JAVAVM \`'\$\$JAVARUNOPTIONS \`'\$\$JAVAMAINCLASS \`'\$\$RUNPARAMETERS\"@) @>
@%@| @}
@%
@%@d write runscript actions @{@%
@%@< runscript line @(\`'\$\$JAVARUN@) @>
@%@| @}

Write the run command in a single line:

@d JavaHome @{m4_javahome@| @}
@d DevRoot @{m4_devroot@| @}
@d JavaVM @{@< JavaHome @>/bin/java@| @}
@d JavasetLibs @{m4_javajre@| @}
@d ExternalJar1 @{m4_extjar1@| @}
@d ExternalJar2 @{m4_extjar2@| @}
@d ExternalJar3 @{m4_extjar3@| @}
@d ExternalClasses  @{@< ExternalJar1 @>:@< ExternalJar2 @>:@< ExternalJar3 @>@| @}
@d Targetdir @{@< DevRoot @>/obj@| @}
@d ClassPath @{@< JavasetLibs @>:@< ExternalClasses @>:@< Targetdir @>@| @}
@d JavaRunOptions @{-classpath @< ClassPath @>@| @}
@d JavaMainClass @{m4_collexispackagename.Search@| @}
@d RunParameters @{fp2 m4_elisabethtweecollexionid@| @}

@d the command to find documents related to  @{@%
@< JavaVM @> @%
@< JavaRunOptions @> @%
@< JavaMainClass @> @%
@1 @2
@| @}

Test this:

@o textcom @{@%
# the command:
@< the command to find documents related to @(fp5@,m4_elisabethtweecollexionid@) @>
@| @}



\subsection{Processing the figures in this document}
\label{sec:figureprocessing}

This document contains figures that have been made by
\texttt{xfig}. Post-process the figures to enable inclusion in this
document.

The list of figures to be included:

@d parameters in Makefile @{@%
FIGFILES=horseshoe annotatestate fileschema mainflow helpeditflow

@| FIGFILES @}

We use the package \texttt{figlatex} to include the pictures. This
package expects two files with extensions \verb|.pdftex| and
\verb|.pdftex_t| for \texttt{pdflatex} and two files with extensions \verb|.pstex| and
\verb|.pstex_t| for the \texttt{latex}/\texttt{dvips}
combination. Probably tex4ht uses the latter two formats too.

Make lists of the graphical files that have to be present for
latex/pdflatex:

@d parameters in Makefile @{@%
FIGFILENAMES=\$(foreach fil,\$(FIGFILES), \$(fil).fig)
PDFT_NAMES=\$(foreach fil,\$(FIGFILES), \$(fil).pdftex_t)
PDF_FIG_NAMES=\$(foreach fil,\$(FIGFILES), \$(fil).pdftex)
PST_NAMES=\$(foreach fil,\$(FIGFILES), \$(fil).pstex_t)
PS_FIG_NAMES=\$(foreach fil,\$(FIGFILES), \$(fil).pstex)

@|FIGFILENAMES PDFT_NAMES PDF_FIG_NAMES PST_NAMES PS_FIG_NAMES@}

Make similar lists for the latex/html (section~\ref{sec:html}):

@d parameters in Makefile @{@%
HTML_PS_FIG_NAMES=\$(foreach fil,\$(FIGFILES), \$(NuwebHtmlDir)/\$(fil).pstex)
HTML_PST_NAMES=\$(foreach fil,\$(FIGFILES), \$(NuwebHtmlDir)/\$(fil).pstex_t)
@| @}





Create the graph files with program \verb|fig2dev|:

@d impliciete make regels @{@%
%.eps: %.fig
	fig2dev -L eps \$< > \$@@

%.pstex: %.fig
	fig2dev -L pstex \$< > \$@@

.PRECIOUS : %.pstex
%.pstex_t: %.fig %.pstex
	fig2dev -L pstex_t -p \$*.pstex \$< > \$@@

%.pdftex: %.fig
	fig2dev -L pdftex \$< > \$@@

.PRECIOUS : %.pdftex
%.pdftex_t: %.fig %.pstex
	fig2dev -L pdftex_t -p \$*.pdftex \$< > \$@@

@| fig2dev @}


\subsection{Bibliography}
\label{sec:bbliography}

To keep this document portable, create a portable bibliography
file. It works as follows: This document refers in the
\texttt|bibliography| statement to the local \verb|bib|-file
\verb|m4_progname.bib|. To create this file, copy the auxiliary file
to another file \verb|auxfil.aux|, but replace the argument of the
command \verb|\bibdata{m4_progname}| to the names of the bibliography
files that contain the actual references (they should exist on the
computer on which you try this). This procedure should only be
performed on the computer of the author. Therefore, it is dependent of
a binary file on his computer.

@d expliciete make regels @{@%
bibfile : m4_progname.aux m4_mkportbib
	m4_mkportbib m4_progname m4_bibliographies

.PHONY : bibfile
@| @}


\subsection{Typesetting a PDF document}
\label{sec:typesetting}

This document can be typeset as a document that is primarily suitable for
printing (i.e.{} a \pdf{} document) or a as a document  that is
primarily suitable to be viewed in a browser (i.e.{} a \textsc{html}
document).

In \LaTeX{}, typesetting is done in a repeating cycle. When the
\LaTeX{} compiler processes a source document, it writes information
like the locations of labels in an auxiliary file. This information
may be needed before it is produced. Therefore, the source has to be
processed another time. In Nuweb, things are even more complicated,
because Nuweb may need information that must be produced by the
\LaTeX{} compiler. Therefore, create a script that repeats execution
of nuweb and \LaTeX{} until the information in the auxiliary file does
no longer change.

@d parameters in Makefile @{@%
W2PDF=./w2pdf
@| @}

m4_dnl
m4_dnl Open compile file.
m4_dnl args: 1) directory; 2) file; 3) Latex compiler
m4_dnl
m4_define(m4_opencompilfil,
`@o '\$1`'\$2` @{@%
#!/bin/bash
# '\$2` -- compile a nuweb file
# usage: '\$2` [filename]
# 'm4_header`
LATEXCOMPILER='\$3`
@< filenames in nuweb compile script @>
@< compile nuweb @>

@| @}
')m4_dnl

m4_opencompilfil(`',`w2pdf',`pdflatex')m4_dnl

The script retains a copy of the latest version of the auxiliary file.
Then it runs the four processors nuweb, \LaTeX{}, MakeIndex and
bib\TeX{}, and compares the latest version with the retained version.


@d compile nuweb @{@%
@< run the processors until the aux file remains unchanged @>
@< remove the copy of the aux file @>
@| @}

The user provides the name of the nuweb file as argument. Strip the
extension (e.g.\ \verb|.w|) from the filename and create the names of
the \LaTeX{} file (ends with \verb|.tex|), the auxiliary file (ends
with \verb|.aux|) and the copy of the auxiliary file (add \verb|old.|
as a prefix to the auxiliary filename).

@d filenames in nuweb compile script @{@%
nufil=\$1
trunk=\${1%%.*}
texfil=\${trunk}.tex
auxfil=\${trunk}.aux
oldaux=old.\${trunk}.aux
indexfil=\${trunk}.idx
oldindexfil=old.\${trunk}.idx
@| nufil trunk texfil auxfil oldaux indexfil oldindexfil @}

Remove the old copy if it is no longer needed.
@d remove the copy of the aux file @{@%
rm \$oldaux
@| @}

Run the three processors. Do not use the option \verb|-o| (to suppres
generation of program sources) for nuweb,  because \verb|w2pdf| must
be kept up to date as well.

@d run the three processors @{@%
nuweb \$nufil
\$LATEXCOMPILER \$texfil
makeindex \$trunk
bibtex \$trunk
@| nuweb makeindex bibtex @}


Repeat to copy the auxiliary file and the index file  and run the processors until the
auxiliary file and the index file are equal to their copies.
 However, since I have not yet been able to test the \verb|aux|
file and the \verb|idx| in the same test statement, currently only the
\verb|aux| file is tested.

It turns out, that sometimes a strange loop occurs in which the
\verb|aux| file will keep to change. Therefore, with a counter we
prevent the loop to occur more than m4_maxtexloops times.

@d run the processors until the aux file remains unchanged @{@%
LOOPCOUNTER=0
while
  ! cmp -s \$auxfil \$oldaux 
do
  if [ -e \$auxfil ]
  then
   cp \$auxfil \$oldaux
  fi
  if [ -e \$indexfil ]
  then
   cp \$indexfil \$oldindexfil
  fi
  @< run the three processors @>
  if [ \$LOOPCOUNTER -ge 10 ]
  then
    cp \$auxfil \$oldaux
  fi;
done
@| @}

The Makefile rule to set the above script to work.

@d expliciete make regels @{@%
m4_progname.pdf : m4_progname.w m4_progname.bib \$(W2PDF) \
                  \$(PDF_FIG_NAMES) \$(PDFT_NAMES)
	chmod 775 \$(W2PDF)
	\$(W2PDF) m4_progname.w

@| @}



\subsection{Typesetting HTML}
\label{sec:html}

\textsc{Html} is easier to read on-line than a \pdf{} document that
was made for printing. We use \verb|tex4ht| to generate \HTML{}
code. An advantage of this system is, that we can include figures
in the same way as we do for \verb|pdflatex|.

Nuweb creates a \LaTeX{} file that is suitable
for \verb|latex2html| if the source file has \verb|.hw| as suffix instead of
\verb|.w|. However, this feature is not compatible with tex4ht.

The \textsc{html} files might have to be located on a place where they are
accessible by the web-server. Therefore, we create a directory at a
suitable place, copy the necessary sourcefiles into it and generate
the \textsc{html}. The following files must be copied:

\begin{enumerate}
\item The nuweb source.
\item Files with figures.
\item The bibliography (\texttt{.bib}) file.
\item The file \texttt{rapport3.4ht}
\end{enumerate}

Apart from this, a special file, needed by \texttt{tex4ht}, must be copied.

Furthermore, Nuweb installs the Bash script \texttt{w2html} into the
html directory.

@d copy to html-dir @{@%
\$(NuwebHtmlDir)/@1 : @1 \$(NuwebHtmlDir)/
	\$(Copy) \$< \$@@

@| @}

@d impliciete make regels @{@%
@< copy to html-dir @(%.pstex@) @>
@< copy to html-dir @(%.pstex_t@) @>
@| @}

@d expliciete make regels @{@%
@< copy to html-dir @(m4_progname.w@) @>
@< copy to html-dir @(m4_progname.bib@) @>
@| @}

We also need a file with the same name as the documentstyle and suffix
\verb|.4ht|. Just copy the file \verb|report.4ht| from the tex4ht
distribution. Currently this seems to work.

@d expliciete make regels @{@%
m4_4htfildest : m4_4htfilsource
	\$(Copy) m4_4htfilsource m4_4htfildest

@| @}

Create a script that performs the translation.

@%m4_`'opencompilfil(m4_htmldocdir/,`w2dvi',`latex')m4_dnl


@o m4_htmldocdir`'/w2html @{@%
#!/bin/bash
# w2html -- make a html file from a nuweb file
# usage: w2html [filename]
#  [filename]: Name of the nuweb source file.
`#' m4_header
echo "translate " \$1 >w2html.log
@< filenames in w2html @>

@< perform the task of w2html @>

@| @}

The script is very much like the \verb|w2pdf| script, but at this
moment I have still difficulties to compile the source smoothly into
\textsc{html} and that is why I make a separate file and do not
recycle parts from the other file. However, the file works similar.


@d perform the task of w2html @{@%
@< run the html processors until the aux file remains unchanged @>
@< remove the copy of the aux file @>
@| @}


The user provides the name of the nuweb file as argument. Strip the
extension (e.g.\ \verb|.w|) from the filename and create the names of
the \LaTeX{} file (ends with \verb|.tex|), the auxiliary file (ends
with \verb|.aux|) and the copy of the auxiliary file (add \verb|old.|
as a prefix to the auxiliary filename).

@d filenames in w2html @{@%
nufil=\$1
trunk=\${1%%.*}
texfil=\${trunk}.tex
auxfil=\${trunk}.aux
oldaux=old.\${trunk}.aux
indexfil=\${trunk}.idx
oldindexfil=old.\${trunk}.idx
@| nufil trunk texfil auxfil oldaux @}

@d run the html processors until the aux file remains unchanged @{@%
LOOPCOUNTER=0
while
  ! cmp -s \$auxfil \$oldaux 
do
  if [ -e \$auxfil ]
  then
   cp \$auxfil \$oldaux
  fi
@%  if [ -e \$indexfil ]
@%  then
@%   cp \$indexfil \$oldindexfil
@%  fi
  @< run the html processors @>
  if [ \$LOOPCOUNTER -ge 10 ]
  then
    cp \$auxfil \$oldaux
  fi;
done
@< run tex4ht @>

@| @}


To work for \textsc{html}, nuweb \emph{must} be run with the \verb|-n|
option, because there are no page numbers.

@d run the html processors @{@%
nuweb -o -n \$nufil
latex -interaction='nonstopmode' \$texfil
makeindex \$trunk
bibtex \$trunk
htlatex \$trunk
@| @}


When the compilation has been satisfied, run makeindex in a special
way, run bibtex again (I don't know why this is necessary) and then run htlatex another time.
@d run tex4ht @{@%
m4_index4ht
makeindex -o \$trunk.ind \$trunk.4dx
bibtex \$trunk
htlatex \$trunk
@| @}

@%@o w2pdf @{@%
@%#!/bin/bash
@%# w2pdf -- make a pdf file from a nuweb file
@%# usage: w2pdf [filename]
@%#  [filename]: Name of the nuweb source file.
@%`#' m4_header
@%echo "translate " \$1 >w2pdf.log
@%@< filenames in w2pdf @>
@%
@%@< perform the task of w2pdf @>
@%
@%@| @}

\subsubsection{Set it to work}
\label{sec:settowork}



Make a dvi file with \texttt{w2html} and then run
\texttt{htlatex}. 

@d expliciete make regels @{@%
m4_htmltarget :  \$(NuwebHtmlDir)/ m4_htmlsource m4_4htfildest \
                 \$(HTML_PS_FIG_NAMES) \$(HTML_PST_NAMES) m4_htmlbibfil
	cd \$(NuwebHtmlDir) && chmod 775 ./w2html
	cd \$(NuwebHtmlDir) && ./w2html m4_progname.w

@| @}



\subsection{Pre-process and unpack the Nuweb source}
\label{sec:nuweb}

As shown in figure~\ref{fig:fileschema} the real source,
\texttt{a\_`'m4_progname`'.w} must be preprocessed to generate the proper
nuweb file. The following two tasks must be performed:

\begin{enumerate}
\item Process \verb|\$| characters.
\item Run the m4 pre-processor.
\end{enumerate}


\subsubsection{Process \qstring{dollar} characters }
\label{sec:procdollars}

Many \qstring{intelligent} \TeX{} editors (e.g.\ the auctex utility of
Emacs) handle \verb|\$| characters as special, to switch into
mathematics mode. This is irritating in program texts, that often
contain \verb|\$| characters as well. Therefore, we make a stub, that
translates the two-character sequence \verb|\\$| into the single
\verb|\$| character.

@d expliciete make regels @{@%
m4_`'m4_progname`'.w : a_`'m4_progname`'.w
	gawk '{gsub(/[\\][\\$\$]/, "$$");print}' a_`'m4_progname`'.w > m4_`'m4_progname`'.w

@% $
@| @}


\subsubsection{Run the M4 pre-processor}
\label{sec:m4}

Run the M4 processor to expand macro's and merge the files
\verb|inst.m4| and \verb|texinclusions.m4|
@d  expliciete make regels @{@%
m4_progname`'.w : m4_`'m4_progname`'.w  inst.m4 texinclusions.m4
	m4 -P m4_`'m4_progname`'.w > m4_progname`'.w

@| @}


\subsubsection{Unpack the nuweb source}
\label{sec:unpack}

Run nuweb to extract the program sources from the nuweb file, but
suppress the creation of the \LaTeX{} documentation.
Nuweb creates only sources that do not yet exist or that have been
modified. Therefore \texttt{make} does not have to check this. 

@d make targets @{@%
sources : m4_progname.w inst.m4 texinclusions.m4 \
          \$(NuwebHtmlDir)/ \$(BinDir) javasourcedirs \$(LibDir)
	nuweb -t m4_progname.w
@< make executables executable @>

@| @}

@d executable @{@%
	chmod 775 @1@%
@| @}



\subsection{Targets}
\label{sec:targets}

The following targets should be useful for the user:

\begin{description}
\item[pdf:] Generate a \pdf{} document.
\item[html:] Generate the \texttt{html} document.
\item[view:] View the document.
\item[print:] Print the document.
\item[run:] Run the program.
\item[lib:] Generate the jar file with the class files.
\end{description}

First the targets for typesetting/viewing:

@d expliciete make regels @{@%

pdf : m4_progname.pdf

html : m4_htmltarget

view : m4_progname.pdf
	\$(DocumentViewer) m4_progname.pdf

print : m4_progname.pdf
	\$(Print) m4_progname.pdf

@| @}



The rules to run and produce a library are a bit more
complicated. Nuweb checks whether the java-file sources have to be
renewed or not. The means, that we cannot set the nuweb source as a
preqequisite for every class file, because this would couse a nuweb
run for every class file in the package. Therefore, run nuweb first in
a sub-process and generate class files and the final targets in
another sub-process:

@d expliciete make regels  @{@%
run : 
	\$(MAKE) \$(MakeOptions) sources
	\$(MAKE) \$(MakeOptions) runjava

lib :
	@@\$(MAKE) \$(MakeOptions) sources
	@@\$(MAKE) \$(MakeOptions) javalib


runjava : \$(JavaClassFullPaths)
	\$(Echo) "Class files: " \$(JavaClassFiles)
	\$(Echo) "Class reqs: " \$(JavaClassFullPaths)
	\$(Echo) \$(JavaRun)
	\$(JavaRun)

javalib : \$(JarFile)

\$(JarFile) : \$(JavaClassFullpaths) \$(LibDir)
	@@cd \$(TargetDir); \$(JavaArchiver) -cf \$@@ \$(JavaClassFiles)

@| @}

Make the class files. First make sure that the destination directories
exist.


@d impliciete make regels @{@%
\$(TargetDir)/%.class : \$(SourceDir)/%.java javadestdirs
	\$(Echo) \$@@
	@@\$(JavaCompiler) \$(JavaCompilerOptions) \$<

%.class : \$(PackageSourceDir)/%.java
	@@\$(MAKE) \$(MakeOptions) \$(PackageTargetDir)/\$@@


@| @}




\subsubsection{The w2pdf script}
\label{sec:w2pdf}

The three processors nuweb, \LaTeX{} and bib\TeX{} are
intertwined. \LaTeX{} and bib\TeX{} create parameters or change the
value of parameters, and write them in an auxiliary file. The other
processors may need those values to produce the correct output. The
\LaTeX{} processor may even need the parameters in a second
run. Therefore, consider the creation of the (\pdf) document finished
when none of the processors causes the auxiliary file to change. This
is performed by a shell script \verb|w2pdf|

Note, that in the following \texttt{make} construct, the implicit rule
\verb|.w.pdf| is not used. It turned out, that make did not calculate
the dependencies correctly when I did use this rule.

@d  impliciete make regels@{@%
@%.w.pdf : 
%.pdf : %.w \$(W2PDF) $(PDF_FIG_NAMES) $(PDFT_NAMES)
	chmod 775 \$(W2PDF)
	\$(W2PDF) \$*

@| @}


@d expliciete make regels  @{@%
\$(W2PDF) : m4_progname.w
	nuweb m4_progname.w
@| @}


\chapter{The style sheet elements}
\label{chap:stylesheet}


@d style sheet elements @{@%
body { font-family: Helvetica, Verdana, Tahoma, Arial, sans-serif,
       Times; 
       background: #cdc; 
       margin: 10px ;
       font-size: small;
    }
@| @}

@d style sheet elements @{@%
#banner {
      padding: 0px;
      width: 100%;
      border-bottom:1px solid #000;
    }
@| @}

@d style sheet elements @{@%

#left {
      width: 20%;
      float: left;
    }
@| @}

@d style sheet elements @{@%
#content {
      background: #fff;
      padding: 0px 20px 10px 20px; 
      border:1px solid #000;
    }
@| @}

@d style sheet elements @{@%
#content #floater {
      float: left;
      padding: 0px 20px 10px 0px; 
    }
@| @}

@d style sheet elements @{@%
#content #menu {
      float: right;
      border: 1px solid #899; 
      margin: 20px 0px 0px 0px;
      padding: 5px 5px 0px 5px;
      color: #899;
      background: #fff;
    } 
@| @}

@d style sheet elements @{@%
#content #menu ul {

     list-style-position: outside;
    }
@| @}

@d style sheet elements @{@%
#content h1, h2, h3, h4 {
      color: #899;
   }
@| @}

@d style sheet elements @{@%
#content th { 
    text-align: left;
    } 
@| @}

@d style sheet elements @{@%
#footer {
      font-size: x-small;
      color: #aaa;
      float: right;
      padding-left: 20px;
      padding-right: 20px;
    }
@| @}

@d style sheet elements @{@%
#navigation { 
      font-size: 120%;
      background:#efe;
      border-left:10px solid #000;
      border-right:1px solid #000;
      padding: 5px 5px 5px 10px;
    }
@| @}


@d style sheet elements @{@%
img {
      border:0
    }

@| @}

@d style sheet elements @{@%
dd {
      padding-bottom: 15px;
}
    
@| @}

@d style sheet elements @{@%
dt {
      font-weight: bold;
    }
@| @}

@d style sheet elements @{@%
#minutes {
      font-family: sans-serif;       
    }
@| @}

@d style sheet elements @{@%
.boxed {
      background: #eee;
      padding-left: 40px;
      border: 1px solid #aaa;
    }
@| @}

@d style sheet elements @{@%
.framed {
      padding-left: 10px;
      background: #eee;
      border: 1px solid #aaa;
    }
@| @}

@d style sheet elements @{@%
.stripe {
      background: #eee;
    }
@| @}

@d style sheet elements @{@%
.done {
      color: #0a0; 
      font-weight: bold; 
    }
@| @}

@d style sheet elements @{@%
.draft {
      color: #f90; 
      font-weight: bold; 
    }
@| @}

@d style sheet elements @{@%
.now {
      color: #00c;
      border: 1px solid #000;
      background: #ddd;
      font-weight: bold; 
    }
@| @}

@d style sheet elements @{@%
.hardright {
     text-align: right;
    }
@| @}

@d style sheet elements @{@%
p .initcap {
      font-size: large;
/*       font-weight: bold; */
    }
@| @}

@d style sheet elements @{@%
.bannerheading {	
      font-weight: bold;
      font-size: 400%;
}
@| @}

@d style sheet elements @{@%
.bannersubheading {
      font-weight: bold;
      font-size: 150%;
      padding-left:20px;
      padding-bottom:15px;
      font-style:italic;
      color: #899;
}
@| @}

@d style sheet elements @{@%
.cert {
	 border:0;
	 width:88px;
	 vertical-align:middle
}
@| @}

@d style sheet elements @{@%
.code {
      background: #dde;
      margin-left: 20px; 
      padding-left: 10px;
      width: auto;
      border: 1px solid #aaa;
    }
@| @}

@d style sheet elements @{@%
.abstract {
      background: #edd;
      margin-left: 20px; 
      padding-left: 10px;
      width: auto;
      border: 1px solid #aaa;
    }
@| @}

@d style sheet elements @{@%
.pub {
      background: #edd;
      margin-left: 20px; 
      margin-bottom: 5px;
      padding-left: 10px;
      width: auto;
      border: 1px solid #aaa;
    }
@| @}

@d style sheet elements @{@%
.cross {
      background: #cff;
      margin-left: 20px; 
      margin-bottom: 5px;
      padding-left: 10px;
      width: auto;
      border: 1px solid #aaa;
    }
@| @}

@d style sheet elements @{@%
.talk {
      background: #ffc;
      margin-left: 20px; 
      margin-bottom: 5px;
      padding-left: 10px;
      width: auto;
      border: 1px solid #aaa;
    }
@| @}

@d style sheet elements @{@%
.misc {
      background: #cfc;
      margin-left: 20px; 
      margin-bottom: 5px;
      padding-left: 10px;
      width: auto;
      border: 1px solid #aaa;
    }


@| @}


\chapter{Resources}
\label{chap:resources}

\section{Relevant verdicts}
\label{sec:relverds}

For each of the fingerprints there is a list of \textsc{ljn} codes of
verdicts for which the associated concept is relevant. These lists
follow here.

Concept 1:
@o m4_verdictslist.fp1 @{@%
AB1335
AD4954
AE2268
@| @}


Concept 2:
@o m4_verdictslist.fp2 @{@%
AF6264
@| @}



Concept 3:
@o m4_verdictslist.fp3 @{@%
AA4000
AB0643
AD4954
AF1817
AO0997
@| @}


Concept 4:
@o m4_verdictslist.fp4 @{@%
AD5317
AD5318
AD7395
AM3305
AO5309
AR5342
AU5661
@| @}

Concept~5:
@o m4_verdictslist.fp5 @{@%
AF6263
AA5320
AA6233
AA7520
AA7914
AA8108
AA8498
AB0034
AB0377
AB1426
AE2690
AE5823
AE6069
AE7351
AF1817
AF8270
AH9070
AI0294
AL1651
AO3453
AO7190
AP0151
AQ5315
AR3253
AR3290
AR5213
AS2026
AT8810
AU4042
AU7713
AU8393
ZC3689
@| @}


Concept 6:
@o m4_verdictslist.fp6 @{@%
AA4000
AA7686
AB0643
AB2149
AD9930
AE2202
AE7345
AF1817
AF2055
AF4658
AH8737
AO1237
AO1558
AO2169
AO6260
AO8132
AP9636
AR3253
AS3250
AS4143
AT3442
AU2940
AU3313
AU3688
AU4042
AU4279
AU7774
@| @}


Concept 7:
@o m4_verdictslist.fp7 @{@%
AA5651
AA5860
AB1202
AD7384
AF0102
AF7885
AI0341
AI0349
AM7964
AR0186
AU0325
@| @}


Concept 8:
@o m4_verdictslist.fp8 @{@%
AT7537
AU4684
@| @}



Concept 9:
@o m4_verdictslist.fp9 @{@%
AA4437
AA4822
AA5526
AD7395
AE3451
AE8549
AF2943
AF9686
AK3432
AO6262
AR8103
AU7713
AU8009
@| @}


Concept 10:
@o m4_verdictslist.fp10 @{@%
AA4000
AA8435
AB0643
AB1338
AD8518
AE7005
AF1817
AF7905
@| @}



Concept 12:
@o m4_verdictslist.fp12 @{@%
AA4000
AA7686
AB0643
AB2149
AD4954
AD8595
AD9930
AE2202
AE7148
AE7345
AF1817
AF2055
AF3455
AF4658
AF6264
AF7419
AH8737
AI0830
AO0997
AO1237
AO1558
AO2169
AO6260
AO8132
AP9636
AR3253
AS3250
AS4143
AT3442
AU2940
AU3313
AU3688
AU4042
AU4279
AU7774
@| @}


Concept~13:
@o  m4_verdictslist.fp13 @{@%
AA7914
AA8108
AA8498
AD3985
AE6069
AE7351
AF1817
AH8822
AI0294
AL1651
AO0997
AP0151
AT7537
AT8665
AT8810
AT8823
AU5877
@|  @}

Concept 14:
@o m4_verdictslist.fp14 @{@%
AA4000
AA6233
AB0034
AB0377
AD3985
AE2690
AE5823
AH8822
AH9070
AI0341
AI0790
AL1651
AO0997
AP1662
AR3253
AR3290
AR5213
AS2026
AT7537
AT8665
AT8823
AU4042
AU5877
AU7713
ZC3689
@| @}


Concept 15:
@o m4_verdictslist.fp15 @{@%
AQ1883
@| @}



The following list contains verdicts that are relevant with respect of
concept~16: \qstring{inbreuk op een recht}
@o m4_verdictslist.fp16 @{@%
AA4000
AF6263
AI0341
AR3253
AR3290
AT7537
@| @}


Concept 17:
@o m4_verdictslist.fp17 @{@%
AD7395
AE3451
AF9686
AU7713
@| @}



Concept 18:
@o m4_verdictslist.fp18 @{@%
AB1426
AE2690
AI0790
AP1662
@| @}

Concept 19:
@o m4_verdictslist.fp19 @{@%
AB1426
AE2690
AF7654
AI0790
AP1662
AU8393
@| @}


Concept 20:
@o m4_verdictslist.fp20 @{@%
AT7537
AU4684
@| @}


Concept 21:
@o m4_verdictslist.fp21 @{@%
AA4038
AA4774
AA6791
AA8110
AA9426
AB1078
AD9917
AE4944
AE6426
AE9843
AH9297
AK4749
AL6908
AM0361
AO0367
AO6211
AO8198
AP8458
AQ1883
AR5041
AR5580
AR8054
AS4624
AS5763
AS8909
AT4972
AT6522
AT9841
AU3080
AU3847
AU3907
AU4832
AU6405
AU6828
AU8231
@| @}



Concept 22:
@o m4_verdictslist.fp22 @{@%
AD5317
AD5318
AD7395
AM3305
AO5309
AR5342
AU5661
@| @}

Concept 24:
@o m4_verdictslist.fp24 @{@%
AA4038
AQ1883
AT9841
@| @}

Concept 25:
@o m4_verdictslist.fp25 @{@%
AA4000
AA8435
AB0643
AB1338
AD8518
AE7005
AF1817
AF7905
@| @}



Concept 26:
@o m4_verdictslist.fp26  @{@%
AF7654
AP1662
@| @}

Concept 28:
@o m4_verdictslist.fp28  @{@%
AA5320
AA6233
@| @}


Concept~29:
@o m4_verdictslist.fp29 @{@%
AA6233
AA7520
AB0034
AB0377
AE2690
AE5823
AE6069
AH9070
AL1651
AR3253
AR3290
AR5213
AS2026
AU4042
AU7713
ZC3689
@| @}

Concept~30:
@o  m4_verdictslist.fp30 @{@%
AB1335
AF6629
AF8270
AO3453
AO7190
AQ5315
@| @}


Concept 32:
@o m4_verdictslist.fp32 @{@%
AA5651
AA5860
AB1202
AD7384
AF0102
AF7885
AI0341
AI0349
AM7964
AR0186
AU0325
@| @}


Concept 33:
@o m4_verdictslist.fp33 @{@%
AB0221
AD8666
AD9917
AE1504
AE5632
AF4512
AF4843
AF4845
AN9389
AO2626
AO6211
AO7690
AO7861
AO8911
AS8832
AT9082
AT9841
AU3080
AU3316
AU3907
AU4279
AU6415
@| @}



Concept 34:
@o m4_verdictslist.fp34 @{@%
AA4734
AD7661
AF8350
AP0151
AP1662
AT7617
AT9011
AU6821
@| @}


Concept 35:
@o m4_verdictslist.fp35 @{@%
AA4000
AB2149
AD8595
AE7148
AF3455
AF7419
AI0830
AS3250
@| @}


Concept 36:
@o m4_verdictslist.fp36 @{@%
AA5526
AD7395
AE3451
AE8549
AF2943
AF9686
AR8103
AU7713
@| @}

\section{Case-groups}
\label{sec:casegroups}

Each of the following files contains in the first line a list of
fingerprint file numbers and on the following lines a list of \ljn's
of verdicts for which the listed concepts are relevant.

@o m4_casegrouplist/FP162A @{@%
5 16 29 30
AA6233
AA7520
AE6069
AF8270
AO3453
AO7190
AQ5315
@| @}

@o m4_casegrouplist/FP162B @{@%
5 13 29
AA6233
AA7520
AA7914
AA8108
AA8498
AE6069
AE7351
AF1817
AI0294
AL1651
AP0151
AT8810
@| @}


@o m4_casegrouplist/FP162C @{@%
5 14 29
AA6233
AA7520
AB0034
AB0377
AE2690
AE5823
AE6069
AH9070
AL1651
AR3253
AR3290
AR5213
AS2026
AU4042
AU7713
ZC3689
@| @}

@o m4_casegrouplist/FP162D @{@%
5 13 14 29
AA6233
AA7520
AD3985
AH8822
AL1651
AO0997
AT7537
AT8665
AT8823
AU5877
@| @}


@o m4_casegrouplist/FP162E @{@%
5 14 16
AA4000
AI0341
AR3253
AR3290
AT7537
@| @}

@o m4_casegrouplist/FP1691A @{@%
18 26 28 29
AA5320
AA6233
AB1426
AE2690
AP1662
@| @}


@o m4_casegrouplist/FP1691D @{@%
5 9 14 18 26 28 29
AA6233
AE2690
AI0790
AP1662
@| @}

@o m4_casegrouplist/FP1692A @{@%
5 19 26
AB1426
AE2690
AF7654
AP1662
AU8393
@| @}


@o m4_casegrouplist/FP1692C @{@%
5 14 19 26
AE2690
AI0790
AP1662
@| @}

@o m4_casegrouplist/FP1701A @{@%
9 17 36
AD7395
AE3451
AF9686
AU7713
@| @}


@o m4_casegrouplist/FP1702A @{@%
9 36
AA5526
AE8549
AF2943
AR8103
AU7713
@| @}


@o m4_casegrouplist/FP171A @{@%
4 22
AD5317
AD5318
AD7395
AM3305
AO5309
AR5342
AU5661
@| @}



@o m4_casegrouplist/FP172A @{@%
34
AA4734
AD7661
AF8350
AP0151
AP1662
AT7617
AT9011
AU6821
@| @}


@o m4_casegrouplist/FP173A @{@%
3 12 16
AA4000
AA7686
AB0643
AB2149
AD4954
AD9930
AE2202
AE7345
AF1817
AF2055
AF4658
AH8737
AO0997
AO1237
AO1558
AO2169
AO6260
AO8132
AP9636
AR3253
AS3250
AS4143
AT3442
AU2940
AU3313
AU3688
AU4042
AU4279
AU7774
@| @}


@o m4_casegrouplist/FP174A @{@%
2 6 12 25 35
AA4000
AB0643
AB2149
AD8595
AE7148
AF1817
AF3455
AF6264
AF7419
AI0830
AS3250
@| @}

@o m4_casegrouplist/FP175A @{@%
15 29 31 35
AA4000
AA7654
AA7914
AA8435
AA8729
AA9840
AA9898
AD9112
AD9930
AE6445
AE7269
AF2005
AF2831
AF3412
AI0294
AP0196
AR6458
AR6459
AS8908
AT7525
AU5626
@| @}

@o m4_casegrouplist/FP176A @{@%
5 7 29 32
AA5651
AA5860
AB1202
AD7384
AF0102
AF7885
AI0341
AI0349
AM7964
AR0186
AU0325
@| @}


@o m4_casegrouplist/FP177A @{@%
8 20
AT7537
AU4684
@| @}

@o m4_casegrouplist/FP179A @{@%
1 11 30
AB1335
AD4954
AE2268
AF6629
@| @}

@o m4_casegrouplist/FP185A @{@%
10 25 27 29
AA4000
AA8435
AB0643
AB1338
AD8518
AE7005
AF1817
AF7905
@| @}

@o m4_casegrouplist/FP194 @{@%
15 21 24
AA4038
AA4774
AA6791
AA8110
AA9426
AB1078
AD9917
AE4944
AE6426
AE9843
AH9297
AK4749
AL6908
AM0361
AO0367
AO6211
AO8198
AP8458
AQ1883
AR5041
AR5580
AR8054
AS4624
AS5763
AS8909
AT4972
AT6522
AT9841
AU3080
AU3847
AU3907
AU4832
AU6405
AU6828
AU8231
@| @}


@o m4_casegrouplist/FP194A @{@%
33
AB0221
AD8666
AD9917
AE1504
AE5632
AF4512
AF4843
AF4845
AN9389
AO2626
AO6211
AO7690
AO7861
AO8911
AS8832
AT9082
AT9841
AU3080
AU3316
AU3907
AU4279
AU6415
@| @}


\bibliographystyle{plain}
\bibliography{display}

\chapter{Indexes}
\label{chap:indexes}

\section{Filenames}
\label{sec:filenames}

@f

\section{Macro's}
\label{sec:macros}

@m

\section{Variables}
\label{sec:veriables}

@u

\printindex

\end{document}

@% deleted materials

@%\subsubsection{The left panel}
@%\label{sec:leftpanel}
@%
@%The left panel lists the relevant concepts.
@%
@%@d functions of index @{@%
@%  function leftpanelcontent(){
@%    @< variables of leftpanelcontent @>
@%    @< make a list of relevant concepts @>
@%    @< present the relevant concepts @>
@%@%   @< maak lijst met uitspraken die de woorden bevatten @>
@%  };
@%@| leftpanelcontent @}
@%
@%Currently, we provide only a limited list of verdicts and a limited
@%list of concepts.
@%
@%@d maak lijst met uitspraken die de woorden bevatten  @{@%
@%printf("`'<h2>Relevante<br> bestanden</h2>");
@%printf("<table>\n");
@%if (\$handle = fopen('m4_tempverdictslist.fp5', "rb")) {
@%  \$i=0;
@%  while(!feof(\$handle)){
@%    #note: strip linefeed with rtrim.
@%    \$file = rtrim(fgets(\$handle));
@%     printf("<tr>");
@%     \$questr=modified_querystring('m4_filenamekeyword',\$file);
@%     printf("<td><a href=\"m4_webURL`'/index.php?%s\">%s</a></td>", \$questr, \$file);
@%@%     printf("<td>%s</td>", \$file);
@%     printf("</tr>\n");
@%     \$i++;
@%  };
@%  fclose(\$handle);
@%  if(\$i>0) printf("</tr>\n");
@%};
@%printf("</table>\n");
@%@| @}
@%
@%Check whether the filename ends with \verb|.html|.
@%
@%@d functions of index  @{@%
@%function filehassuffix(\$file, \$suffix){
@%  \$pattern="/".\$suffix."\$/";
@%  if(preg_match(\$pattern, \$file)){
@%   return true;
@%  } else {
@%   return false;
@%  };
@%};
@%@| filehassuffix @}
@%
@%
@%
@%\label{displayfile}
@%
@%@d print the verdict that has been passed as argument @{@%
@%?>
@%<table>
@%<tr>
@%  <td>
@%    <?php
@%      if(\$conceptset->is_active_concept(5)){
@%        printf("%s\n",\$uittext=file_get_contents("m4_fingerprinttextdir/fp5"));
@%      };
@%    ?>
@%  </td>
@%</tr>
@%<tr>
@%  <td>
@%    <?php
@%      if (\$handle = fopen('m4_tempverdictslist', "rb")) {
@%        \$i=0;
@%        while(!feof(\$handle)){
@%          #note: strip linefeed with rtrim.
@%          \$file = rtrim(fgets(\$handle));
@%@%          printf("<tr>");
@%          \$questr=modified_querystring('m4_filenamekeyword',\$file);
@%          printf("<a href=\"m4_webURL`'/index.php?%s\">%s</a> ", \$questr, \$file);
@%@%        printf("<td>%s</td>", \$file);
@%@%        printf("</tr>\n");
@%         \$i++;
@%        };
@%         fclose(\$handle);
@%      };
@%    ?>
@%  </td>
@%</tr>
@%<tr>
@%  <td>
@%    <?php
@%    @< button to select entire doc or relevant parts only @>
@%    ?>
@%  </td>
@%</tr>
@%<tr>
@%  <td>
@%  <?php
@%    printf("<h2>Uitspraak %s</h2>\n", \$filnam);
@%    @< placeholder for the annotated verdict @>
@%@%    printannotatedverdict(\$filnam, \$conceptset);
@%  ?>
@%  </td>
@%</tr>
@%</table>
@%<?php
@%@| m4_filenamekeyword @}


@%Print the names of the concepts in the right panel.
@%
@%@d functions of index @{@%
@%  function rightpanelcontent(){
@%    printf("<H2>Concepten</H2>\n");
@%    @< print a list of concepts @>
@%  }
@%
@%@| rightpanelcontent @}

@%Print the concepts that can be found in the fingerprint
@%files. Currently, we just use two fingerprints as a test.
@%
@%Find out whether one of the concepts is going to be used. Print that
@%first, and print the other one below.
@%
@%@d print a list of concepts @{@%
@%global \$conceptset;
@%@%\$conceptarg=parameter_value_of('m4_conceptnumkeyword');
@%if(\$conceptset->active_concept_count>0){
@%  \$ca=\$conceptset->arra();
@%  @< print the active concepts @>
@%};
@%if(count(\$conceptar)<m4_nrofconcepts){
@%  @< print the inactive concepts @>
@%};
@%@|  @}
@%
@%@d print the active concepts @{@%
@%printf("<h3>gebruikt concept</h3>\n");
@%printf("<table>\n<tr>\n");
@%\$conceptcounter=0;
@%foreach(\$ca as \$conceptnum){
@%  \$conceptcounter++;
@%  \$seqn="p".telwoordvan(\$conceptcounter);
@%  \$frasn="f".telwoordvan(\$conceptcounter);
@%  @< print pointer to selected concept @(\$conceptnum@,\$seqn@,\$frasn@) @>
@%};
@%if(\$conceptcounter>1){
@%  @< print combination colours @(\$conceptcounter@) @>
@%}
@%printf("</tr>\n</table>\n");
@%@| @}
@%
@%@d print the inactive concepts @{@%
@%printf("<h3>niet-gebruikte concepten</h3>\n");
@%printf("<table>\n<tr>\n");
@%for(\$i=1;\$i<=m4_nrofconcepts;\$i++){
@%  if((!isset(\$ca))||(!in_array(\$i,\$ca))){
@%    @< print pointer to deselected  concept @(\$i@,unusedconcept@) @>
@%  };
@%};
@%printf("</tr>\n</table>\n");
@%@| @}
@%
@%};
@%if(\$conceptarg==3){
@%  @< printargnarg @(3@,15@) @>
@%} else {
@%   if(\$conceptarg==15){
@%   @< printargnarg @(15@,3@) @>
@%   } else {
@%     @< printnargnarg @(3@,15@) @>
@%   };
@%}

@%@d printargnarg @{@%
@%\$activeconceptnum=@1;
@%\$passiveconceptnum=@2;
@%printf("<h3>gebruikt concept</h3>\n");
@%printf("<table>\n<tr>\n");
@%@< print pointer to concept @((0-\$activeconceptnum)@,m4_conceptparone@) @>
@%printf("</tr>\n</table>\n");
@%printf("<h3>niet-gebruikt concept</h3>\n");
@%printf("<table>\n<tr>\n");
@%@< print pointer to concept @(\$passiveconceptnum@,m4_conceptpartwo@) @>
@%printf("</tr>\n</table>\n");
@%@| @}
@%
@%@d printnargnarg @{@%
@%\$firstconceptnum=@1;
@%\$secondconceptnum=@2;
@%printf("<h3>niet-gebruikt concept</h3>\n");
@%printf("<table>\n<tr>\n");
@%@< print pointer to concept @(\$firstconceptnum@,m4_conceptpartwo@) @>
@%printf("<tr>\n");
@%@< print pointer to concept @(\$secondconceptnum@,m4_conceptpartwo@) @>
@%printf("</tr>\n</table>\n");
@%@| @}

@%@d standaardinhoud @{<?php
@%@< initialize xajax @>
@%@< definities @>
@%@%global @< globale parameters @>;
@%
@%@< init code @>
@%\$paginatitel="@1"; 
@%@%printf("<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>\n");
@%printf("<?xml version=\"1.0\" encoding=\"utf-8\"?>\n");
@%?>
@%<!DOCTYPE html 
@%     PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
@%    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
@%<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="nl" lang="nl">
@%  <head>
@%   @< the html statements in the header @>
@%  </head>
@%  <body>
@%    @< the html statements in the body @>
@%    <?php
@%      @< init javascript @>
@%    ?>
@%  </body>
@%</html>
@%<?php
@%@< php functions @>
@%?>
@%@| @}



% Local IspellDict: british 

% LocalWords:  BATNA MakeIndex webdir weburl printf tr feof querystring parnam
% LocalWords:  params http parval php str filnam printannotatedverdict strlen
% LocalWords:  chunksize foreach html javascript init javascripts onmouseover
% LocalWords:  tooltips tooltip matchpoint

