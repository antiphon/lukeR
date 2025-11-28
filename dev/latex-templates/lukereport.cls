\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lukereport}[2021/09/29 Luke report class] 

\LoadClass{report}

\RequirePackage[table]{xcolor} 
\RequirePackage{graphicx}


% COLORS
\definecolor{lukeblue}{RGB}{0,181,226}
\definecolor{lukeorange}{RGB}{255,130,0}
\definecolor{lukedarkgray}{RGB}{84,88,90}
\definecolor{lukedarkblue}{RGB}{0,51,160}
\definecolor{lukefuchsia}{RGB}{225,60,152}
\definecolor{lukegreen}{RGB}{120,190,32}
\definecolor{lukeviolet}{RGB}{127,63,152}

% A4 paper
\setlength{\paperheight}{297mm}%
\setlength{\paperwidth}{210mm}

% Margins
\RequirePackage[left=0.98in, right=0.98in, top=1in,bottom=1in]{geometry}

% Fonts
\RequirePackage{fontspec}
\setmainfont[BoldFont=selawkb.ttf]{selawk.ttf}
%\setsansfont[Ligatures=TeX]{Arial Narrow}
\setsansfont[Ligatures=TeX]{Arial Narrow}

%% In case not English
\DeclareOption{finnish}{
	% do stuff
	\typeout{"Suomeksi tulee."}
}

%
\DeclareOption*{
	\PassOptionsToClass{\CurrentOption}{report}
}
%
\ProcessOptions\relax


% Headers and footers
\usepackage{fancyhdr}
\fancyhf{}
\fancyhead[C]{\color{gray}\small{\bf[Natural resources and bioeconomy  
studies XX/20XX]}}
\fancypagestyle{plain}{%
	\fancyhf{}%
	\fancyhead[C]{\color{gray}\small{\bf[Natural resources and 
	bioeconomy studies XX/20XX]}}
	\fancyfoot[C]{\color{gray}\small{\bf\thepage}}%
}
%\fancyfoot[C]{}
\renewcommand{\headrulewidth}{0pt}
\pagestyle{fancy}


% Title, section head colors
\RequirePackage{titlesec}
%\titleformat*{\section}{\color{black}\LARGE\bf}
%\titleformat*{\subsection}{\color{black}\large\bf}
%\titleformat*{\subsection}{\color{lukedarkgray}}
% Remove the "Chapter x" from chapters
\titleformat{\chapter}[hang]{\color{lukedarkgray}\normalfont\bfseries\huge}
				{\thechapter.}
				{10pt}
				{\color{lukedarkgray}}
\titleformat{\section}[hang]{\color{black}\normalfont\bfseries\LARGE}
                {\thesection.}
                {10pt}
                {\color{black}}        
\titleformat{\subsection}[hang]{\color{black}\normalfont\bfseries\large}
                {\thesubsection.}
                {10pt}
                {\color{black}}        				

\titlelabel{\thetitle.}
				
%\titlespacing{\chapter}{0pt}{\parskip}{-\parskip}
\titlespacing{\chapter}{0pt}{0pt plus 4pt minus 2pt}{10pt plus 2pt minus 2pt}
\titlespacing{\section}{0pt}{12pt plus 4pt minus 2pt}{8pt plus 2pt minus 2pt}
\titlespacing{\subsection}{0pt}{12pt plus 4pt minus 2pt}{8pt plus 2pt minus 2pt}
\titlespacing{\subsubsection}{0pt}{12pt plus 4pt minus 2pt}{8pt plus 2pt minus 2pt}


% no intent anywhere
\setlength\parindent{0pt}
% paragraph spacing
\setlength{\parskip}{1em}


% Figures:
% define figure numbering:
\renewcommand{\thefigure}{\arabic{figure}}


% Tables
% Numbering:
\renewcommand{\thetable}{\arabic{table}}

% Table header coloring hack
\makeatletter
\newcommand*{\@rowstyle}{}
\newcommand*{\rowstyle}[1]{% sets the style of the next row
	\gdef\@rowstyle{#1}%
	\@rowstyle\ignorespaces%
}
\newcolumntype{+}{% adds the current row style to the next column
	>{\@rowstyle}%
}
\newcolumntype{=}{% resets the row style
	>{\gdef\@rowstyle{}}%
}
\makeatother


