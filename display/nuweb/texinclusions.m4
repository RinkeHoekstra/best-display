\documentclass[a4paper,twoside]{rapport3}
\pagestyle{headings}
% packages
\usepackage{pdfswitch}
\usepackage{ae,aeguill}
\usepackage{color}
\usepackage{ifthen}
\usepackage{ifpdf}
\usepackage{figlatex}
\usepackage{makeidx}
\usepackage{a4wide}
\usepackage{alltt}
\usepackage{color}
\usepackage{lmodern}
\usepackage[latin1]{inputenc}
\usepackage[T1]{fontenc}
\usepackage[british]{babel}
% title
\newcommand{\thedoctitle}{m4_doctitle}
\newcommand{\theauthor}{m4_author}
\newcommand{\thesubject}{m4_subject}
\title{\thedoctitle}
\author{\theauthor}
\date{m4_docdate}
% indexing
\renewcommand{\indexname}{General index}
\makeindex
% new commands
%
% Commands for frequently used terms
%
\newcommand{\ID}{\textsc{id}}
\newcommand{\pdf}{\textsc{pdf}}
\newcommand{\serql}{\textsc{serql}}
\newcommand{\sparql}{\textsc{sparql}}
\newcommand{\uri}{\textsc{uri}}
\newcommand{\HTML}{\textsc{html}}
\newcommand{\batna}{\textsc{batna}}
\newcommand{\best}{\textsc{best}}
\newcommand{\ljn}{\textsc{ljn}}
\newcommand{\php}{\textsc{php}}
\newcommand{\xml}{\textsc{xml}}
% new commands for non-standard constructions
\newcommand{\num}[1]{\oldstylenums{#1}}
\newcommand{\kdag}[3]{\ifcase#2\or
    January\or February\or March\or April\or May\or June\or July\or
    August\or September\or October\or November\or December\fi~\num{#1},~\num{#3}}
%PDF/html specific settings. Copied from pdfswitch
\ifpdf
% \usepackage[pdftex]{graphicx}       %%% graphics for dvips
% \usepackage[pdftex]{thumbpdf}      %%% thumbnails for ps2pdf
% \usepackage[pdftex]{thumbpdf}      %%% thumbnails for pdflatex
% \usepackage[pdftex,                %%% hyper-references for pdflatex
% bookmarks=true,%                   %%% generate bookmarks ...
% bookmarksnumbered=true,%           %%% ... with numbers
% a4paper=true,%                     %%% that is our papersize.
% hypertexnames=false,%              %%% needed for correct links to figures !!!
% breaklinks=true,%                  %%% break links if exceeding a single line
% linkbordercolor={0 0 1}]{hyperref} %%% blue frames around links
% %                                  %%% pdfborder={0 0 1} is the
% %                                  default
% \hypersetup{
%   pdfauthor   = {\theauthor},
%   pdftitle    = {\thedoctitle},
%   pdfsubject  = {web program},
%  }
 \renewcommand{\NWlink}[2]{\hyperlink{#1}{#2}}
 \renewcommand{\NWtarget}[2]{\hypertarget{#1}{#2}}
 \renewcommand{\NWsep}{$\diamond$\rule[-1\baselineskip]{0pt}{1\baselineskip}}
\else
% \usepackage[dvips]{graphicx}        %%% graphics for dvips
%\usepackage[latex2html,             %%% hyper-references for ps2pdf
%bookmarks=true,%                   %%% generate bookmarks ...
%bookmarksnumbered=true,%           %%% ... with numbers
%hypertexnames=false,%              %%% needed for correct links to figures !!!
%breaklinks=true,%                  %%% breaks lines, but links are very small
%linkbordercolor={0 0 1},%          %%% blue frames around links
%pdfborder={0 0 112.0}]{hyperref}%  %%% border-width of frames 
\usepackage{html}
\renewcommand{\NWlink}[2]{\hyperlink{#1}{#2}}
\renewcommand{\NWtarget}[2]{\hypertarget{#1}{#2}}
\fi
\ifpdf
  \newcommand{\extref}[2]{%
    #1~(\href{#2}{\url{#2}})%
  }%
\else
  \newcommand{\extref}[2]{%
    \href{#2}{#1}%
  }%
\fi
%
% Settings
%
\raggedbottom
\makeatletter
\if@@oldtoc
  \renewcommand\toc@@font[1]{\relax}
\else
  \renewcommand*\toc@@font[1]{%
    \ifcase#1\relax
    \chaptocfont
    \or\slshape
    \or\rmfamily
    \fi}
\fi
\makeatother
\newcommand{\chaptocfont}{\large\bfseries}

\newcommand{\pdfpsinc}[2]{%
\ifpdf
  \input{#1}
\else
  \input{#2}
\fi
}
m4_changequote(`?',`!')m4_dnl
\newcommand{\qstring}[1]{``?#!1''}
m4_define(m4_quotverb, ?``\verb|$1|''!)m4_dnl
m4_changequote(?`!,?'!)m4_dnl
