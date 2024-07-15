%Developer by Yusuf Kursat Tuncel

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{kgtu}[2024/06/23 KGTU Thesis Class]
% required files:
% main.tex - This is your main text
% abbrev.tex - List of Abbreviations. Just use ABBRV - Explanation format
%cv.tex - CV in free format, only required for PhD Thesis
%references.bib - References in biblatex format.
%Optional
%supplementary.tex
%if don't need it, remove it or change the name.


\LoadClass[12pt,a4paper]{report}
%\LoadClass[12pt,a4paper,twoside]{report}

% Required packages
\RequirePackage[backend=biber,style=ieee,sorting=none]{biblatex}
% \RequirePackage[backend=biber,style=ieee,sorting=none,uniquelist=false,uniquename=false,backref=true,isbn=false,url=false,doi=false,eprint=false,hyperref=true,block=ragged,dashed=false]{biblatex}

\RequirePackage[left=4cm,right=2.5cm,top=2.5cm,bottom=2.5cm]{geometry}
\RequirePackage{titling}
\RequirePackage{emptypage}
\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\RequirePackage{etoolbox}
\RequirePackage{xstring}
\RequirePackage{setspace}
\RequirePackage{microtype}
\RequirePackage{ragged2e} 
\RequirePackage{tocloft}
\RequirePackage{datatool}
\RequirePackage{lastpage}
\RequirePackage{lipsum}
\RequirePackage{parskip}
\RequirePackage{longtable}
\RequirePackage{float}
\RequirePackage{tabularx}
\RequirePackage{array}
\RequirePackage{xstring}
\RequirePackage{graphicx}
\RequirePackage{array}
\RequirePackage[caption=false,font=normalsize,labelfont=sf,textfont=sf]{subfig}
\RequirePackage{booktabs}
\RequirePackage{color}
\RequirePackage{subfig}
\RequirePackage{fontspec}
\RequirePackage[normalem]{ulem}
\RequirePackage{enumitem}
\RequirePackage{listofitems}


% \RequirePackage{lmodern}
% \RequirePackage{newtxtext}
% \RequirePackage{newtxmath}

% \newcommand{\approvaldate}[1]{\def\@approvaldate{#1}}
% \newcommand{\monthyear}[1]{\def\@monthyear{#1}}
% \newcommand{\monthyeartr}[1]{\def\@monthyeartr{#1}}

\setmainfont{Times New Roman}

\setlist[itemize]{leftmargin=*}
\setlist[enumerate]{leftmargin=*}


% First, we'll save the original \begin{document} and \end{document} behavior
\let\originaldocument\document
\let\endoriginaldocument\enddocument

% Now we redefine the document environment
\renewenvironment{document}{%
    \originaldocument
    \input{preamble}
    %Do not modify this unless you have a good reason to do so.
    % Title pages
    \maketitle
    \makeinnertitle
    
    % Front matter
    \frontmatter
    
    \makeapproval
    
    \makeabstract
    \makeabstracttr
    \makeacknowledgement
    \maketextofoath
    
    \makefrontmatter
    
    % Main matter
    \mainmatter
}{%
    %This is the end of your text.
    \makereferences
    
    %keep here as it is.
    \makeatletter
    \ifx\@thesistype\@phdthesistype
        \makecv
    \fi
    \makeatother
    %keep here as it is.
    %if you have supplemantary data, uncomment the following line.
    \iffilenotempty{supplementary.tex}{\makesupplementary}
    % Your supplementary material goes here
    \endoriginaldocument
}
%% Refences are passing beyond the page boundries because of titles.

\renewbibmacro*{title}{%
  \ifboolexpr{
    test {\iffieldundef{title}}
    and
    test {\iffieldundef{subtitle}}
  }
    {}
    {\printtext{%
     \printtext[titlecase]{\usefield{\uline}{title}}%
     \setunit{\subtitlepunct}%
     \printfield[titlecase]{subtitle}}%
     \newunit}%
  \printfield{titleaddon}}
  
\newcommand{\smallerfont}{\fontsize{10}{12}\selectfont}
\newcommand{\largerfont}{\fontsize{14}{17}\selectfont}

% Format for sections
\titleformat{\section}
  {\normalfont\fontsize{12}{18}\selectfont\bfseries}{\thesection}{1em}{}
\titlespacing*{\section}
  {0pt}{3.25ex plus 1ex minus .2ex}{1.5ex plus .2ex}

\newcommand{\sectionspace}{\vspace{0.5\baselineskip}}

\let\oldsection\section
\renewcommand{\section}[1]{%
  \oldsection{#1}%
  \begingroup
  \setstretch{1.5}%
  \sectionspace
  \endgroup
}

\titleformat{\subsection}
  {\normalfont\fontsize{12}{18}\selectfont\bfseries}{\thesubsection}{1em}{}

\titlespacing*{\subsection}
  {0pt}{3.25ex plus 1ex minus .2ex}{1.5ex plus .2ex}

\newcommand{\subsectionspace}{\vspace{0.5\baselineskip}}

\let\oldsubsection\subsection
\renewcommand{\subsection}[1]{%
  \oldsubsection{#1}%
  \begingroup
  \setstretch{1.5}%
  \subsectionspace
  \endgroup
}


\let\oldref\ref
\renewcommand{\ref}[1]{%
  \IfBeginWith{#1}{fig:}{{Figure~\oldref{#1}}}{%
    \IfBeginWith{#1}{tab:}{{Table~\oldref{#1}}}{%
     \IfBeginWith{#1}{eqn:}{{Equation~\oldref{#1}}}{%
      \IfBeginWith{#1}{alg:}{{Algorithm~\oldref{#1}}}{%
                \oldref{#1}%
       }
      }
    }%
  }%
}

\setlength{\parindent}{0pt} 

\tolerance=9999
\emergencystretch=3em
\DeclareFieldFormat{labelnumberwidth}{\makebox[2em][l]{#1.}}


\let\oldfigure\figure
\let\endoldfigure\endfigure

\captionsetup[figure]{font=normal, labelfont=bf, justification=raggedright, singlelinecheck=false, labelsep=period}

\renewenvironment{figure}[1][htbp]{%
    \oldfigure[#1]%
    \centering
}{%
    \endoldfigure
}

% \newcommand{\figurecaption}[1]{%
%     \captionsetup{justification=raggedright,singlelinecheck=false}%
%     \makebox[\linewidth]{%
%         \parbox{\linewidth}{\caption{#1}}%
%     }%
% }

% Redefine the table environment
\let\oldtable\table
\let\endoldtable\endtable

\captionsetup[table]{font=normal,labelfont=bf, justification=raggedright, singlelinecheck=false, labelsep=period}

\renewenvironment{table}[1][htbp]{%
    \oldtable[#1]%
    \centering
    \setlength{\tabcolsep}{4pt}% Adjust horizontal padding
    \renewcommand{\arraystretch}{1.2}% Adjust vertical padding
}{%
    \endoldtable
}

% Patch tabular and tabularx to be full width by default
\AtBeginEnvironment{tabular}{\setlength{\tabcolsep}{4pt}\renewcommand{\arraystretch}{1.2}}
\AtBeginEnvironment{tabularx}{\setlength{\tabcolsep}{4pt}\renewcommand{\arraystretch}{1.2}}

% Create a command for full-width tabularx
\newcommand{\fulltabularx}[1]{%
    \tabularx{\textwidth}{#1}%
}
\usepackage[skip=2pt]{caption}


% \captionsetup[figure]{font=normal, labelfont=bf, justification=raggedright, singlelinecheck=false,  labelsep=period
% }


\newcommand{\starttwoside}{%
    \clearpage
\newgeometry{twoside,left=2.5cm,right=2.5cm,top=2.5cm,bottom=2.5cm,bindingoffset=1.5cm}
}



% Set default line spacing to 1.5
\setstretch{1.5}

% Fine-tune font settings
\microtypesetup{stretch=10, shrink=10, step=2}

% Define variables
\newcommand{\universityname}[1]{\def\@universityname{#1}}
\newcommand{\gradschoolname}[1]{\def\@gradschoolname{#1}}
\newcommand{\departmentname}[1]{\def\@departmentname{#1}}
\newcommand{\departmentnametr}[1]{\def\@departmentnametr{#1}}

\newcommand{\thesistitle}[1]{\def\@thesistitle{#1}}
\newcommand{\thesistitletr}[1]{\def\@thesistitletr{#1}}

\newcommand{\thesistype}[1]{\def\@thesistype{#1}}
\newcommand{\thesistypetr}[1]{\def\@thesistypetr{#1}}

\newcommand{\thesistypeshort}[1]{\def\@thesistypeshort{#1}}
\newcommand{\thesisdegree}[1]{\def\@thesisdegree{#1}}
\newcommand{\authorname}[1]{\def\@authorname{#1}}
\newcommand{\place}[1]{\def\@place{#1}}


\newcommand{\supervisortitle}[1]{\def\@supervisortitle{#1}}
\newcommand{\supervisortitletr}[1]{\def\@supervisortitletr{#1}}
\newcommand{\supervisorpos}[1]{\def\@supervisorpos{#1}}
\newcommand{\supervisorpostr}[1]{\def\@supervisorpostr{#1}}
\newcommand{\supervisorname}[1]{\def\@supervisorname{#1}}
\newcommand{\supervisoraffiliation}[1]{\def\@supervisoraffiliation{#1}}

\newcommand{\cosupervisor}[1]{\def\@cosupervisor{#1}}
\newcommand{\cosupervisorinjury}[1]{\def\@cosupervisorinjury{#1}}
\newcommand{\cosupervisortitle}[1]{\def\@cosupervisortitle{#1}}
\newcommand{\cosupervisortitletr}[1]{\def\@cosupervisortitletr{#1}}
\newcommand{\cosupervisorpos}[1]{\def\@cosupervisorpos{#1}}
\newcommand{\cosupervisorpostr}[1]{\def\@cosupervisorpostr{#1}}
\newcommand{\cosupervisorname}[1]{\def\@cosupervisorname{#1}}
\newcommand{\cosupervisoraffiliation}[1]{\def\@cosupervisoraffiliation{#1}}

\def\@phdthesistype{Doctor of Philosophy Thesis}

\newcommand{\departmentheadtitle}[1]{\def\@departmentheadtitle{#1}}
\newcommand{\departmentheadname}[1]{\def\@departmentheadname{#1}}
\newcommand{\departmentheadposname}[1]{\def\@departmentheadposname{#1}}
\newcommand{\directortitle}[1]{\def\@directortitle{#1}}
\newcommand{\directorname}[1]{\def\@directorname{#1}}
\newcommand{\directorposname}[1]{\def\@directorposname{#1}}
\newcommand{\numberofpages}[1]{\def\@numberofpages{#1}}
\newcommand{\abstracttext}[1]{\def\@abstracttext{#1}}
\newcommand{\abstracttexttr}[1]{\def\@abstracttexttr{#1}}

\newcommand{\keywords}[1]{\def\@keywords{#1}}
\newcommand{\keywordstr}[1]{\def\@keywordstr{#1}}

\newcommand{\acknowledgementtext}[1]{\def\@acknowledgementtext{#1}}

\newcommand{\approvaldate}[1]{\global\def\@approvaldate{#1}}

% \newcommand{\monthyear}[1]{\global\def\@monthyear{#1}}
% \newcommand{\monthyeartr}[1]{\global\def\@monthyeartr{#1}}

\newcommand{\setmonthyear}[2]{%
  \ifcase#1\or
    \newcommand{\monthyear}{January, #2}%
    \newcommand{\monthyeartr}{Ocak, #2}%
  \or
    \newcommand{\@monthyear}{February, #2}%
    \newcommand{\@monthyeartr}{Şubat, #2}%
  \or
    \newcommand{\@monthyear}{March, #2}%
    \newcommand{\@monthyeartr}{Mart, #2}%
  \or
    \newcommand{\@monthyear}{April, #2}%
    \newcommand{\@monthyeartr}{Nisan, #2}%
  \or
    \newcommand{\@monthyear}{May, #2}%
    \newcommand{\@monthyeartr}{Mayıs, #2}%
  \or
    \newcommand{\@monthyear}{June, #2}%
    \newcommand{\@monthyeartr}{Haziran, #2}%
  \or
    \newcommand{\@monthyear}{July, #2}%
    \newcommand{\@monthyeartr}{Temmuz, #2}%
  \or
    \newcommand{\@monthyear}{August, #2}%
    \newcommand{\@monthyeartr}{Ağustos, #2}%
  \or
    \newcommand{\@monthyear}{September, #2}%
    \newcommand{\@monthyeartr}{Eylül, #2}%
  \or
    \newcommand{\@monthyear}{October, #2}%
    \newcommand{\@monthyeartr}{Ekim, #2}%
  \or
    \newcommand{\@monthyear}{November, #2}%
    \newcommand{\@monthyeartr}{Kasım, #2}%
  \or
    \newcommand{\@monthyear}{December, #2}%
    \newcommand{\@monthyeartr}{Aralık, #2}%
  \fi
}

\newcommand{\setdatesfromapproval}{%
  \setsepchar{,||.||;||:}
  \readlist*\mylist{\@approvaldate}
  \setmonthyear{\mylist[2]}{\mylist[3]}%
}


% Title page
\renewcommand{\maketitle}{%
\setdatesfromapproval
    \begin{titlepage}
        \begin{center}
        \fontsize{16}{16}\selectfont\bfseries  % 16pt font size with 24pt leading (1.5 line spacing)
        \vspace*{2\baselineskip}  % 2 x 1.5 line spacing before university name
        \MakeUppercase{\@universityname}\par
        \MakeUppercase{\@gradschoolname}\par
        \MakeUppercase{\@departmentname}\par
        \vspace{2\baselineskip}  % 2 x 1.5 line spacing
        \MakeUppercase{\@thesistitle}\par
        \vspace{2\baselineskip}  % 2 x 1.5 line spacing
        \MakeUppercase{\@thesistype}\par
        \vspace{2\baselineskip}  % 2 x 1.5 line spacing
        {\fontsize{12}{12}\selectfont\bfseries  % 12pt font size with 18pt leading (1.5 line spacing)
        \@authorname\par
        \vspace{2\baselineskip}  % 2 x 1.5 line spacing
        {\MakeUppercase{\@place}\par}
        {\MakeUppercase{\@monthyear}\par}}
        \end{center}
    \end{titlepage}
    \newpage\null\thispagestyle{empty}\newpage
}

% Inner title page
\newcommand{\makeinnertitle}{%
    \begin{titlepage}
        \begin{center}
        \fontsize{12}{12}\selectfont\bfseries  % 16pt font size with 24pt leading (1.5 line spacing)
        \vspace*{2\baselineskip}  % 2 x 1.5 line spacing before university name
        \MakeUppercase{\@universityname}\par
        \MakeUppercase{\@gradschoolname}\par
        \vspace{1\baselineskip}  % 2 x 1.5 line spacing
        \MakeUppercase{\@thesistype}\par
        \vspace{2\baselineskip}  % 2 x 1.5 line spacing
        \MakeUppercase{\@thesistitle}\par
        \vspace{2\baselineskip}  % 2 x 1.5 line spacing
        \@authorname\par
        \vspace{2\baselineskip}  % 2 x 1.5 line spacing
        \@supervisorpos: \@supervisortitle\ \@supervisorname\par
        \vspace{1\baselineskip}  % 2 x 1.5 line spacing
                % Add co-supervisor if exists
        \ifx\@cosupervisor\undefined\else
            \@cosupervisorpos: \@cosupervisortitle\ \@cosupervisorname\par
            \vspace{0.5\baselineskip}
        \fi
        \vspace{1\baselineskip}  % 2 x 1.5 line spacing
        \@departmentname\par
        \vspace{48pt}  
        \vspace{2\baselineskip}  % 2 x 1.5 line spacing
        {\MakeUppercase{\@place}\par}
        {\MakeUppercase{\@monthyear}\par}
        \end{center}
    \end{titlepage}
    \thispagestyle{empty}
}

\newcommand{\sigline}{%
  \hspace{\fill}\makebox[4cm]{\dotfill}%
}
\newcommand{\makeapproval}{%
    \thispagestyle{empty}
    \normalfont\mdseries 
    \setlength{\parindent}{0pt}
    \hyphenpenalty=10000
    \vbox{\parbox[t]{\linewidth}{\singlespacing\justifying\noindent
    This study titled \textbf{``\@thesistitle''}, prepared by \@authorname\ has been accepted with consensus by the following jury on \@approvaldate\ as a \@thesistype\ in the \MakeUppercase{\@departmentname}.\par}}
    \vspace{48pt}
    \vbox{\parbox[t]{\linewidth}{\singlespacing\justifying
    \noindent\@supervisorpos: \@supervisortitle\ \@supervisorname \sigline\par
    \noindent\@supervisoraffiliation\par 
    \vspace{18pt}

    \ifx\@cosupervisor\undefined\else
        \noindent\@cosupervisorpos: \@cosupervisortitle\ \@cosupervisorname \sigline\par
        \noindent\@cosupervisoraffiliation\par 
        \vspace{18pt}%
    \fi
    
    \DTLforeach*{jury}{\title=title, \name=name, \role=role, \affiliation=affiliation}{%
        \noindent\role: {\title} \name \sigline\par
        \noindent\affiliation\par 
        \vspace{18pt}
            }
        }
    }
    \vspace{18pt}
    \vbox{\parbox[t]{\linewidth}{\noindent\singlespacing\justifying
    \setlength{\parindent}{0pt}
    \hyphenpenalty=10000
    I certify that this thesis which has been accepted by the jury satisfies all the requirements as a thesis for the degree of \@thesisdegree.\par}}
    \vspace{18pt}
    \vbox{\singlespacing
        \raggedleft
        \@departmentheadtitle\ \@departmentheadname\par\noindent
        \@departmentheadposname\par
    }
    \vspace{18pt}
    \raggedright
    \vbox{\singlespacing
        Approval of The Graduate School\par
        \vspace{0.5cm}
        \raggedleft
        \@directortitle\ \@directorname\par\noindent
        \@directorposname\par
    }
    \newpage
}

% Abstract
\newcommand{\makeabstract}{%
   \starttwoside
    \addcontentsline{toc}{chapter}{ABSTRACT}
    \thispagestyle{plain}
    \centering
    \vbox{{\largerfont\textbf{ABSTRACT}}\par}
    \vspace{28pt}
    {\bfseries \@thesistitle\par}
    \vspace{28pt}
    \@authorname\par
    \vspace{14pt}
    \@thesistype, \@departmentname\par
    \@supervisorpos: \@supervisortitle\ \@supervisorname\par
        % Add co-supervisor if exists
        \ifx\@cosupervisor\undefined\else
            \@cosupervisorpos: \@cosupervisortitle\ \@cosupervisorname\par
        \fi
    
    \@monthyear, \pageref{LastPage}\ pages\par
    \vspace{28pt}
    \vbox{\parbox[t]{\linewidth}{\singlespacing\justifying\noindent
    \@abstracttext\par}}
    \vspace{28pt}
        \vbox{\parbox[t]{\linewidth}{\singlespacing\justifying\noindent
    \textbf{Keywords:} \@keywords}}
    \newpage
}

\newcommand{\makeabstracttr}{%
    \addcontentsline{toc}{chapter}{ÖZET}
    \thispagestyle{plain}
    \centering
    \vbox{{\largerfont\textbf{ÖZET}}\par}
    \vspace{28pt}
    {\bfseries \@thesistitletr\par}
    \vspace{28pt}
    \@authorname\par
    \vspace{14pt}
    \@thesistypetr, \@departmentnametr\par
    \@supervisorpostr : \@supervisortitletr\ \@supervisorname\par
        \ifx\@cosupervisor\undefined\else
            \@cosupervisorpostr: \@cosupervisortitletr\ \@cosupervisorname\par
        \fi    
    \@monthyeartr, \pageref{LastPage} sayfa\par
    \vspace{28pt}
    \vbox{\parbox[t]{\linewidth}{\singlespacing\justifying\noindent
    \@abstracttexttr\par}}
    \vspace{28pt}
        \vbox{\parbox[t]{\linewidth}{\singlespacing\justifying\noindent
    \textbf{Anahtar kelimeler:} \@keywordstr}}
    \newpage
}


% Acknowledgement
\newcommand{\makeacknowledgement}{%
    \addcontentsline{toc}{chapter}{ACKNOWLEDGEMENTS}
    \thispagestyle{plain}
    \centering
    \vbox{\largerfont\textbf{ACKNOWLEDGEMENTS}\par}
    \vspace{28pt}
    {%
        \setlength{\parindent}{0pt}% Remove paragraph indentation
        \singlespacing
        \justifying
        \begin{minipage}{\dimexpr\textwidth-1cm\relax}
            \setlength{\parskip}{12pt}% Increase space between paragraphs
            \@acknowledgementtext
            (written in \LaTeX)
        \end{minipage}%
    }%
    \vspace{28pt}
    \par
    \vbox{\singlespacing
        \raggedleft
        \@authorname\ \\
        \@approvaldate\par\noindent
    }
    \newpage
}

\newcommand{\maketextofoath}{%
    \addcontentsline{toc}{chapter}{TEXT OF OATH}   
    \thispagestyle{plain}
    \begin{center}
    {\bfseries\largerfont TEXT OF OATH}
    \end{center}
    \setlength{\parindent}{0pt} 
    \vspace{28pt}
    \vbox{\parbox[t]{\linewidth}{
    \singlespacing
    The study I presented as my {\@thesistype} titled {\bfseries``\@thesistitle''} has been written without  applying  to  any  assistance  inconsistent  with  the  scientific  ethics  and traditions, and all sources I have benefited from were listed in bibliography and I have used them by means of making references and I declare and confirm this with my honor.}}
    \vspace{28pt}
    \vbox{\parbox[t]{\linewidth}{\singlespacing
     \raggedleft
       \@authorname\ \\
        \@approvaldate\par\noindent
    }}
    \newpage
}


\newcommand{\frontmatter}{%
    \clearpage
    \pagenumbering{roman}
    \setcounter{page}{2}
    \pagestyle{frontmatter}
}


\titleformat{\chapter}[hang]
  {\normalfont\largerfont\bfseries\raggedright}
  %{\makebox[0pt][r]{\thechapter.}}{14pt}{\large}
{\thechapter.}{1em}{\large}
\titlespacing*{\chapter}{0pt}{-20pt}{0pt}

% Page style
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L,RO]{\thepage}
\fancyhead[R]{\leftmark}
\fancyhead[LO]{\rightmark}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

\fancypagestyle{frontmatter}{%
  \fancyhf{}% Clear all headers and footers
  \fancyfoot[C]{\thepage}% Page number in center of footer
  \renewcommand{\headrulewidth}{0pt}% No header rule
  \renewcommand{\footrulewidth}{0pt}% No footer rule
}

\def\@tocl{LIST OF CONTENTS}
\def\@lot{LIST OF TABLES}
\def\@lof{LIST OF FIGURES}
\def\@loab{LIST OF ABBREVIATIONS}
\def\@chapterslabel{CHAPTERS}
\def\@bibliographylabel{BIBLIOGRAPHY}
\def\@APPENDIXlabel{APPENDICES}
\def\@figureslabel{FIGURES}
\def\@tableslabel{TABLES}
\def\@tablelabel{Table}

% Chapter entries
\renewcommand{\cftchapleader}{\cftdotfill{\cftchapdotsep}}
\setcounter{tocdepth}{2}

% Table of contents formatting
\renewcommand{\cfttoctitlefont}{\hfil\Large\bfseries}
\renewcommand{\cftaftertoctitle}{\hfill}

% Table of contents formatting for chapters
\renewcommand{\cftchappresnum}{}
\renewcommand{\cftchapaftersnum}{.}
\renewcommand{\cftchapaftersnumb}{\hspace{1em}}
\renewcommand{\cftchapleader}{\cftdotfill{\cftchapdotsep}}
\renewcommand{\cftchapfont}{\normalfont}
\renewcommand{\cftchappagefont}{\normalfont}

\renewcommand{\cftsecaftersnumb}{\hspace{1em}}
\renewcommand{\cftsubsecaftersnumb}{\hspace{1em}}
\renewcommand{\cftsecfont}{\normalfont}
\renewcommand{\cftsecpagefont}{\normalfont}

% Section entries (for non-chapter entries)
\renewcommand{\cftsecfont}{\normalfont}
\renewcommand{\cftsecpagefont}{\normalfont}
\renewcommand{\cftsecleader}{\cftdotfill{\cftsecdotsep}}

% Set up dotted style for table of contents
\renewcommand{\cftchapdotsep}{\cftdotsep}
\renewcommand{\cftsecdotsep}{\cftdotsep}
\renewcommand{\cftsubsecdotsep}{\cftdotsep}
\renewcommand{\cftdotsep}{0.5}

% Adjust spacing
\setlength{\cftbeforechapskip}{0pt}
\setlength{\cftbeforesecskip}{0pt}

% Ensure page numbers are right-aligned
\renewcommand{\cftchapleader}{\cftdotfill{\cftchapdotsep}}
\renewcommand{\cftsecleader}{\cftdotfill{\cftsecdotsep}}
\renewcommand{\cftsubsecleader}{\cftdotfill{\cftsubsecdotsep}}
\renewcommand{\cfttoctitlefont}{\hfil\Large\bfseries}

% Chapter entries
\renewcommand{\cftchappresnum}{}
\renewcommand{\cftchapaftersnum}{.}
\renewcommand{\cftchapaftersnumb}{\hspace{1em}}
\renewcommand{\cftchapleader}{\cftdotfill{\cftchapdotsep}}
\renewcommand{\cftchapfont}{\normalfont}
\renewcommand{\cftchappagefont}{\normalfont}

% Section entries
\renewcommand{\cftsecpresnum}{}
\renewcommand{\cftsecaftersnum}{.}
\renewcommand{\cftsecaftersnumb}{\hspace{1em}}
\renewcommand{\cftsecfont}{\normalfont}
\renewcommand{\cftsecpagefont}{\normalfont}
\renewcommand{\cftsecleader}{\cftdotfill{\cftsecdotsep}}

\renewcommand{\cftsubsecpresnum}{}
\renewcommand{\cftsubsecaftersnum}{.}
\renewcommand{\cftsubsecfont}{\small\normalfont}
\renewcommand{\cftsubsecpagefont}{\small\normalfont}
\renewcommand{\cftsubsecleader}{\cftdotfill{\cftsecdotsep}}

\renewcommand{\cftsecpresnum}{}
\renewcommand{\cftsecaftersnum}{}
\renewcommand{\cftsecaftersnumb}{\hspace{0.5em}}
\renewcommand{\cftsecfont}{\small}
\renewcommand{\cftsecpagefont}{\small}


% Ensure chapter titles are uppercase in TOC
\patchcmd{\l@chapter}
  {\cftchapfont #1}
  {\cftchapfont\MakeUppercase{#1}}
  {}{}

%Ensure that there are no extra spaces between chapters in List of Figures and List of Tables.
\patchcmd{\@chapter}{\addtocontents{toc}{\protect\addvspace{10\p@}}}{}{}{}% ToC
\patchcmd{\@chapter}{\addtocontents{lof}{\protect\addvspace{10\p@}}}{}{}{}% LoF
\patchcmd{\@chapter}{\addtocontents{lot}{\protect\addvspace{10\p@}}}{}{}{}% LoT

% Table of contents formatting
\renewcommand{\cfttoctitlefont}{\hfill\largerfont\bfseries}
\renewcommand{\cftaftertoctitle}{%
    \hfill\null\\\null\hfill
    \makebox[3em][r]{\textbf{Page}}\hspace{-0.3em}\vspace{-2.5em}
}
\setlength{\cftbeforetoctitleskip}{-0.5cm}
\setlength{\cftaftertoctitleskip}{28pt}
\cftsetindents{chapter}{0em}{0em}
\cftsetindents{section}{1em}{1em}
\cftsetindents{subsection}{2.5em}{2em}

% Format List of Figures entries
\renewcommand{\cftfigpresnum}{Figure }
\renewcommand{\cftfigaftersnum}{.}
\renewcommand{\cftfigaftersnumb}{\hspace{1em}}
\renewcommand{\cftfigfont}{\normalfont}
\renewcommand{\cftfigpagefont}{\normalfont}
\renewcommand{\cftfigleader}{\cftdotfill{\cftfigdotsep}}
\setlength{\cftfignumwidth}{6em}
\cftsetindents{figure}{1em}{4em}

% Center-align and format List of Figures title
\renewcommand{\cftloftitlefont}{\hfil\largerfont\bfseries}
\renewcommand{\cftafterloftitle}{\hfil\vspace{1em}}

% Center-align and format List of Tables title
\renewcommand{\cftlottitlefont}{\hfil\largerfont\bfseries}
\renewcommand{\cftafterlottitle}{\hfil\vspace{1em}}


% Format List of Tables entries
\renewcommand{\cfttabpresnum}{Table }
\renewcommand{\cfttabaftersnum}{.}
\renewcommand{\cfttabaftersnumb}{\hspace{1em}}
\renewcommand{\cfttabfont}{\normalfont}
\renewcommand{\cfttabpagefont}{\normalfont}
\renewcommand{\cfttableader}{\cftdotfill{\cfttabdotsep}}
\setlength{\cfttabnumwidth}{6em}
\cftsetindents{table}{1em}{4em}

\counterwithin{figure}{chapter}
\counterwithin{table}{chapter}

\renewcommand{\contentsname}{LIST OF CONTENTS}
\renewcommand{\listfigurename}{LIST OF FIGURES}
\renewcommand{\listtablename}{LIST OF TABLES}

\newcommand{\newlistoffigures}{%
    \begingroup
    \singlespacing
    \begin{center}
        \largerfont\bfseries{\listfigurename}
    \end{center}
    \vspace{28pt}  % Add some space after the title
    \setstretch{1.5} 
    \@starttoc{lof}%
    \endgroup
}

\newcommand{\newlistoftables}{%
    \begingroup
    \singlespacing
    \begin{center}
        \largerfont\bfseries{\listtablename}
    \end{center}
    \vspace{28pt}  % Add some space after the title
    \setstretch{1.5}
    \@starttoc{lot}
    \endgroup
}

\newcommand{\makelistofabbreviations}{%
    \addcontentsline{toc}{chapter}{LIST OF ABBREVIATIONS}
    \thispagestyle{plain}
    \begin{center}
    {\bfseries\largerfont LIST OF ABBREVIATIONS}
    \vspace{28pt}  % Add some space after the title
    
    \end{center}
    \begin{flushleft}
        \fontsize{12}{18}\selectfont 
        \setlength{\parskip}{0pt} 
        \input{abbrev}
    \end{flushleft}
    \newpage
}

% List of contents, figures, tables, abbreviations
\newcommand{\makefrontmatter}{%
    \addcontentsline{toc}{chapter}{LIST OF CONTENTS}
    \tableofcontents
  % {\singlespacing\listofcontents}
    \normalsize
    \clearpage
    \addcontentsline{toc}{chapter}{LIST OF FIGURES}
    \newlistoffigures
    \clearpage
    \addcontentsline{toc}{chapter}{LIST OF TABLES}
    \newlistoftables
    \clearpage
    \makelistofabbreviations
    \clearpage
}


% Arabic numeral pages
\newcommand{\mainmatter}{%
    \clearpage
    \pagenumbering{arabic}
    \setcounter{page}{1}
    \justifying
    \setlength{\parindent}{0pt}
    \setlength{\parskip}{1em}
    \setlength{\parfillskip}{0pt plus 1fil}
    \fontsize{12}{18}\selectfont  % 12pt font size with 18pt (1.5x) line spacing
    \onehalfspacing  % Ensures 1.5 line spacing
}

% References formatting
\renewcommand{\bibsetup}{%
  \setlength{\leftmargin}{0pt}%
  \setlength{\itemindent}{-\leftmargin}%
  \setlength{\itemsep}{6pt}%
  \setlength{\parsep}{0pt}%
  \setlength{\parskip}{0pt}%
  \setlength{\emergencystretch}{5em}
}

\addbibresource{references.bib}

\newcommand{\makereferences}{%
    \clearpage
    \phantomsection
    \addcontentsline{toc}{chapter}{REFERENCES}
    \fancypagestyle{references}{%
        \fancyhf{}  % Clear all header and footer fields
        \fancyfoot[C]{\thepage}  % Page number at the bottom center
        \renewcommand{\headrulewidth}{0pt}  % Remove the header rule
        \renewcommand{\footrulewidth}{0pt}  % Remove the footer rule
    }
    \pagestyle{references}
    \begin{center}
        \largerfont\textbf{REFERENCES}
    \end{center}
    \vspace{48pt}
    \printbibliography[heading=none]
}

% Curriculum Vitae
\newcommand{\makecv}{%
    \clearpage
    \phantomsection
    \addcontentsline{toc}{chapter}{CURRICULUM VITAE}
    \begin{center}
    {\bfseries\largerfont CURRICULUM VITAE}
    \end{center}
    \vspace{48pt}
    \input{cv}  
}
%Supplementary
% In your preamble or before \begin{document}
\newcommand{\iffilenotempty}[2]{%
  \IfFileExists{#1}{%
    \begingroup\endlinechar=-1\relax%
    \everyeof{\noexpand}%
    \expandafter\ifx\expandafter\relax\expandafter\detokenize\expandafter{\input{#1}}\relax%
      \endgroup%
    \else%
      \endgroup%
      #2%
    \fi%
  }{}%
}


\newcommand{\makesupplementary}{%
    \clearpage
    \phantomsection
    \addcontentsline{toc}{chapter}{SUPPLEMENTARY MATERIAL}
    \begin{center}
    {\bfseries\largerfont SUPPLEMENTARY MATERIAL}
    \end{center}
    \vspace{48pt}
    \input{supplementary}
}

\let\@enddoc=\enddocument
\def\enddocument{\label{`@lastpage'}\@enddoc }