\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lukereport}[2021/09/29 Luke report class] 

\LoadClass{report}

\RequirePackage{xcolor}
\RequirePackage{graphicx}

% A4 paper
\setlength{\paperheight}{297mm}%
\setlength{\paperwidth}{210mm}

% Margins
\RequirePackage[left=0.98in, right=0.98in, top=0.55in,bottom=0.55in]{geometry}

% Fonts
\RequirePackage{fontspec}
\setmainfont[BoldFont=selawkb.ttf]{selawk.ttf}


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


% headers and footers
\usepackage{fancyhdr}
\fancyhf{}
\fancyhead[C]{\small{\bf[Natural resources and bioeconomy studies XX/20XX]}}
\fancyfoot[C]{}
\renewcommand{\headrulewidth}{0pt}
\pagestyle{fancy}

% Remove the "Chapter x" from chapters
\RequirePackage{titlesec}
\titleformat{\chapter}[hang]{\normalfont\bfseries\Huge}{\thechapter. 
}{10pt}{}