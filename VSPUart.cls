%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Стилевой класс для поготовки статей в сборник
%%  LaTeX class for preparing papers to VSPU-2024
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Класс VSPUart по умолчанию подключает следующие стандартные стилевые пакеты
% (в скобках название семейства, в которое входит пакет):
% amsthm (всегда), amsmath (amsmath),  amstext (amsmath), amsbsy (amsmath),
% amsfonts (amsfonts), amssymb (amsfonts), eucal (amsfonts), eufrak (amsfonts),
% cite (cite), bm (tools), graphicx (graphicx), indentfirst (feature),
% sectsty (feature), titlesec (feature), verbatim (hyperref), listings (hyperref),
% hyperref (hyperref).
% В случае, если из-за отсутствия какого-либо семейства пакетов Вам не удаётся
% откомпилировать файл, Вы можете запретить подключение пакетов из этого семейства
% используя необязательный аргумент noXXX, где XXX - название семейства. Например,
% пакет bm может быть отключен с помощью необязательного аргумента notools.
% Необязательный аргумент noext запрещает подключение всех пакетов.

% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% ! Ошибки на стадии компиляции, возникшие внутри стилевого класса VSPUart и связанные с
% ! не полной совместимостью различных версий TeX, как правило, могут быть устранены
% ! использованием необязательных аргументов eng и noext.
% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

\NeedsTeXFormat{LaTeX2e}[1998/12/01]
\ProvidesClass{vspuart}[2013/10/10 v1.0
LaTeX class for preparing papers to VSPU (2013)]

\newif\ifhyperref\hyperreftrue
\DeclareOption{nohyperref}{\hyperreffalse}

\newif\iffeature\featuretrue
\DeclareOption{nofeature}{\featurefalse}

\newif\ifamsmath\amsmathtrue
\DeclareOption{noamsmath}{\amsmathfalse}

\newif\ifamsfonts\amsfontstrue
\DeclareOption{noamsfonts}{\amsfontsfalse}

\newif\ifcite\citetrue
\DeclareOption{nocite}{\citefalse}

\newif\iftools\toolstrue
\DeclareOption{notools}{\toolsfalse}

\newif\ifgraphicx\graphicxtrue
\DeclareOption{nographicx}{\graphicxfalse}

\newif\iffancyhdr\fancyhdrtrue
\DeclareOption{nofancyhdr}{\fancyhdrfalse}

\DeclareOption{noext}{\hyperreffalse\featurefalse\amsmathfalse\amsfontsfalse\citefalse\toolsfalse\graphicxfalse}

\ProcessOptions

\LoadClass[12pt,a4paper,fleqn,leqno]{article}    %  стандартный класс
\RequirePackage{amsthm}           %  управление стилем окружений типа теорема, команда \theoremstyle


\iffancyhdr
\RequirePackage{fancyhdr}
\fi

%%  AMSmath
\ifamsmath
   \RequirePackage[fleqn,leqno]{amsmath}          %  расширенные возможности для нумерации формул и табуляции
   \RequirePackage{amstext}          %  русские буквы в формулах, команда \text
   \RequirePackage{amsbsy}           %  жирные математические символы, команды \boldsymbol и \pmb
\fi

%%  AMSfonts
\ifamsfonts
   \RequirePackage{amssymb}          %  дополнительные символы, например \leqslant (подключает amsfonts)

%%  Знаки нестрогих равенств
   \let\oldle\le
   \let\oldge\ge
   \let\le\leqslant
   \let\ge\geqslant
   \let\leq\leqslant
   \let\geq\geqslant

   \let\oldemptyset\emptyset
   \let\emptyset\varnothing

   \RequirePackage{amsfonts}         %  дополнительные математические символы, команда \mathbb
\else
   \def\mathbb#1{#1}
   \let\leqslant\le
   \let\geqslant\ge
\fi

%%  Cite
\ifcite
   \RequirePackage[sort]{cite}       %  "сжатие" ссылок
\fi

%%  Tools
\iftools
   \RequirePackage{bm}               %  жирные математический выражения, команды \bm и \hm
\fi

\ifhyperref
   \RequirePackage{verbatim}
   \RequirePackage{listings}
   \lstset{extendedchars = true,             % чтобы были русские буквы
        basicstyle       = \small\ttfamily,  % стиль пишущей машинки - базовый
        commentstyle     = \itshape,         % комментарии курсивом
        keywordstyle     = \underbar,        % ключевые слова подчёркивать
        language=TeX,                        % язык по умолчанию
        belowcaptionskip = 5pt,
        xleftmargin      = 0.75cm,           % левое поле
        xrightmargin     = 0.75cm}           % правое поле

   \RequirePackage[colorlinks, urlcolor=blue, pdfborder={0 0 0 [0 0]},unicode]{hyperref}
   \let\oldurl\url
   \def\url#1{\textcolor{blue}{\underline{\oldurl{#1}}}}
\else
   \def\textcolor#1#2{#2}
   \def\href#1#2{#2}
   \def\url#1{\underline{#1}}
   \def\verbatim{\begingroup\tt}
   \def\endverbatim{\endgroup}
\fi

\iffeature
   \RequirePackage{indentfirst} % отступ у первого абзаца
   \RequirePackage{sectsty}     % модификация заголовков разделов
   \RequirePackage{titlesec}
   \sectionfont{\centering\boldmath}
   \subsectionfont{\centering\boldmath}
   \subsubsectionfont{\normalsize\boldmath}
   \titleformat{\subsubsection}[runin]{\normalfont\bfseries}{\thesubsubsection}{0.5em}{}[.~~~]
   \titlespacing{\subsubsection}{\parindent}{1.5ex plus .6ex minus .5ex}{0pt}
\fi

%%  Режим pdfTeX
\newif\ifpdf
\ifx\pdfoutput\undefined
   \pdffalse
\else
   \pdfoutput=1
   \pdftrue
\fi

%%  Графика
\ifgraphicx
   \ifpdf
      \RequirePackage[pdftex]{graphicx}
   \else
      \RequirePackage[dvips]{graphicx}
   \fi
\fi

%%  Список литературы
\def\thebibliography#1{\section*{\CYRS\cyrp\cyri\cyrs\cyro\cyrk\space\cyrl\cyri\cyrt\cyre\cyrr\cyra\cyrt\cyru\cyrr\cyrery}
\addcontentsline{toc}{chapter}{\CYRS\cyrp\cyri\cyrs\cyro\cyrk\space\cyrl\cyri\cyrt\cyre\cyrr\cyra\cyrt\cyru\cyrr\cyrery}
\footnotesize
  \list{{\arabic{enumi}.\hspace*{8pt}}}
      {
       \settowidth\labelwidth{[#1]\hspace*{9pt}}
       \leftmargin\labelwidth
       \advance\leftmargin\labelsep
       \usecounter{enumi}
       \partopsep = 0pt
       \parsep    = 0pt
       \itemsep   = 0pt
      }
 \def\newblock{\hskip .11em plus .33em minus .07em}
 \sloppy
 \clubpenalty  = 4000
 \widowpenalty = 4000
 \sfcode`\.=1000\relax
}

%%  Нумерация страниц
\pagestyle{plain}


%%  Горизонтальные интервалы
\textwidth      =   16cm % ширина текста
\oddsidemargin  =    0cm % величина левого поля (1in)
\evensidemargin =    0cm % величина левого поля (1in)
\parindent      = 0.75cm % величина абзацного отступа
\mathindent     = 2.50cm % отступ в выделенных формулах

%%  Предел растяжимости строки
\emergencystretch = 3pt

%%  Вертикальные интервалы
\voffset          = -1.5cm % верхнее поле (1in)
\topmargin        = 0cm % вертикальный интервал между верхним колонтитулом и верхним полем
\headheight       = 0.5cm % высота верхнего колонтитула
\headsep          = 1cm % вертикальный интервал между верхним колонтитулом и текстом
\normalsize             % установка правильного \baselineskip
\textheight       = 48\baselineskip   % высота текста
\renewcommand{\baselinestretch}{1.01} % интерлиньяж
\belowcaptionskip = 0.5em % отступ после подписей к рисунку или таблице


\normalsize \pagestyle{fancy}\chead{\thepage} \lfoot{}
\cfoot{}\rfoot{}

\fancyhf{} %
\fancyhead[C]{\footnotesize \thepage}
\renewcommand{\headrulewidth}{0pt}


\renewcommand{\footrulewidth}{1pt}
\fancyfoot[CO,CE]{\scriptsize
{\noindent XIV ВСЕРОССИЙСКОЕ СОВЕЩАНИЕ ПО ПРОБЛЕМАМ УПРАВЛЕНИЯ
\\\noindent
ВСПУ-2024
\\\noindent
Москва 17-20 июня 2024 г.\\}}





%%  Отступы вокруг теорем
\topsep    = 1pt
\partopsep = 1pt

%%  Нумерация разделов
\renewcommand{\thesection}{\arabic{section}.}
\renewcommand{\thesubsection}{\thesection\arabic{subsection}.}
\renewcommand{\thesubsubsection}{\thesubsection\arabic{subsubsection}.}

%%  Точка после рис. и отступы подписи к рисунку
\makeatletter
\newlength\@captionsize
\renewcommand{\@makecaption}[2]{
\setlength\@captionsize{0.8\hsize}
\vskip\abovecaptionskip
\sbox{\@tempboxa}{\footnotesize #1. #2}
\ifdim \wd\@tempboxa>\@captionsize
\hbox to \hsize {\hfil\parbox{\@captionsize}{\footnotesize #1. #2}\hfil}
\else \global\@minipagefalse
  \hbox to \hsize {\hfil\box\@tempboxa\hfil}
\fi
\vskip\belowcaptionskip}

%%  Теоремы и доказательства
\renewenvironment{proof}
{\vspace\topsep\par{\bf%
Доказательство.\,\ }\ignorespaces}%
{\noindent\vspace\partopsep}

% для пакетного определения теоремы с номером и теоремы без номера
\def\nth#1#2{\newtheorem{#1}{\hspace{\parindent}\MakeUppercase#2}\newtheorem*{#1*}{\hspace{\parindent}\MakeUppercase#2}}

% для пакетного определения утверждений с доказательствами
\def\npth#1#2#3{\nth{#1}{#2}
\newenvironment{proof#1}[1]
{\vspace\topsep\par{\bf Доказательство~\MakeLowercase{#3}\, \ref{##1}.\,\ }\ignorespaces}
{\noindent\vspace\partopsep}}

%%  Определение утверждений с доказательствами
\npth{theorem}{\CYRT\cyre\cyro\cyrr\cyre\cyrm\cyra}{\cyrt\cyre\cyro\cyrr\cyre\cyrm\cyrery}
\npth{lemma}{\CYRL\cyre\cyrm\cyrm\cyra}{\cyrl\cyre\cyrm\cyrm\cyrery}
\npth{corollary}{\CYRS\cyrl\cyre\cyrd\cyrs\cyrt\cyrv\cyri\cyre}{\cyrs\cyrl\cyre\cyrd\cyrs\cyrt\cyrv\cyri\cyre\cyrya}
\npth{statement}{\CYRU\cyrt\cyrv\cyre\cyrr\cyrzh\cyrd\cyre\cyrn\cyri\cyre}{\cyru\cyrt\cyrv\cyre\cyrr\cyrzh\cyrd\cyre\cyrn\cyri\cyrya}
\npth{proposal}{\CYRP\cyrr\cyre\cyrd\cyrl\cyro\cyrzh\cyre\cyrn\cyri\cyre}{\cyrp\cyrr\cyre\cyrd\cyrl\cyro\cyrzh\cyre\cyrn\cyri\cyrya}

%%  Определение других окружений типа теорем
\nth{remark}{\CYRZ\cyra\cyrm\cyre\cyrch\cyra\cyrn\cyri\cyre}
\nth{definition}{\CYRO\cyrp\cyrr\cyre\cyrd\cyre\cyrl\cyre\cyrn\cyri\cyre}
\nth{assumption}{\CYRP\cyrr\cyre\cyrd\cyrp\cyro\cyrl\cyro\cyrzh\cyre\cyrn\cyri\cyre}
\nth{example}{\CYRP\cyrr\cyri\cyrm\cyre\cyrr}
\nth{problem}{\CYRZ\cyra\cyrd\cyra\cyrch\cyra}
\nth{algorithm}{\CYRA\cyrl\cyrg\cyro\cyrr\cyri\cyrt\cyrm}
\nth{iteration}{\CYRI\cyrt\cyre\cyrr\cyra\cyrc\cyri\cyro\cyrn\cyrn\cyra\cyrya\space\cyrs\cyrh\cyre\cyrm\cyra}

%%  Формирование титула доклада
\newcounter{autcnt}
\def\aut#1{\addtocounter{autcnt}{1}\expandafter\def\csname aut\arabic{autcnt}\endcsname{#1}
\expandafter\def\csname unlock\arabic{autcnt}\endcsname##1{##1}}
\def\org#1{\expandafter\def\csname org\arabic{autcnt}\endcsname{#1}}
\def\adr#1{\expandafter\def\csname adr\arabic{autcnt}\endcsname{#1}}
\def\email#1{\expandafter\def\csname ema\arabic{autcnt}\endcsname{#1}}

\def\prn#1{\csname unlock#1\endcsname{
\begin{center}{\vspace*{\baselineskip}{\bf \csname aut#1\endcsname}\break
\footnotesize\it \csname org#1\endcsname\break
\rm\csname adr#1\endcsname\break
E-mail:\/\space\textcolor{blue}{\underline{\href{mailto:\csname ema#1\endcsname}{\csname ema#1\endcsname}}}}
\end{center}}}

\newcounter{precnt}
\def\pre{\addtocounter{precnt}{1}
\expandafter\def\csname aut\arabic{precnt}\endcsname{\textcolor{red}{{\bf укажите автора командой {\tt\string\aut\{...\}} }}}
\expandafter\def\csname org\arabic{precnt}\endcsname{\textcolor{red}{{\bf укажите официальное название организации командой {\tt\string\aut\{...\}}  }}}
\expandafter\def\csname adr\arabic{precnt}\endcsname{\textcolor{red}{{\bf укажите адрес организации командой {\tt\string\adr\{...\}}  }}}
\expandafter\def\csname ema\arabic{precnt}\endcsname{\textcolor{red}{{\bf укажите e-mail командой {\tt\string\ema\{...\}}  }}}
\expandafter\def\csname unlock\arabic{precnt}\endcsname##1{\relax}
}

\pre\pre\pre\pre\pre\pre\pre\pre\pre\pre\pre\pre\pre\pre\pre\pre\pre\pre\pre\pre\pre

\newenvironment{Abstract}{\noindent УДК~\udkcontent\par\vspace*{1.5\baselineskip}
\begin{center}{\begingroup\def\\{\break}\fontsize{18pt}{23pt}\selectfont\bf\titlecontent\endgroup}\end{center}
\prn1\prn2\prn3\prn4\prn5\prn6\prn7\prn8\prn9\prn{10}\prn{11}\prn{12}\prn{13}
\hspace{1.25cm}\begin{minipage}{13.5cm}\vspace*{2.5\baselineskip}\noindent\footnotesize{\bf Ключевые слова:}\/\space\keycontent\par\vspace*{2\baselineskip}\noindent\footnotesize{\bf Аннотация:}\/\space\ignorespaces}{\end{minipage}\\[\baselineskip]\vspace*{0.5\baselineskip}}

\def\keycontent{\textcolor{red}{{\bf укажите командой {\tt\string\Keywords\{...\}}  }}}
\def\udkcontent{\textcolor{red}{{\bf укажите командой {\tt\string\UDK\{...\}}  }}}
\def\titlecontent{\textcolor{red}{{\bf УКАЖИТЕ НАЗВАНИЕ ДОКЛАДА КОМАНДОЙ {\tt\string\Title\{...\}}  }}}
\long\def\Keywords#1{\long\gdef\keycontent{#1}}
\long\def\UDK#1{\long\gdef\udkcontent{\ignorespaces#1}}
\long\def\Title#1{\long\gdef\titlecontent{\MakeUppercase{#1}}}

%%  Перенос в формулах (А. Н. Канатников)
\newcommand{\mhyph}[1]{#1\penalty10000\discretionary{}{\hbox{$#1$}}{}}

%%  Дефис, допускающий перенос (А. Н. Канатников)
\def\nf-{\nobreak\hskip0pt\discretionary{-}{}{-}\nobreak\hskip0pt}

%%  Обозначения числовых множеств
\def\R{\mathbb{R}}
\def\C{\mathbb{C}}
\def\N{\mathbb{N}}
\def\Z{\mathbb{Z}}
\def\Q{\mathbb{Q}}

\endinput % (A. V. Gorbunov, 01/11/2013)
