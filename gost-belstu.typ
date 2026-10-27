/*

«ГОСТ»  БГТУ.

модель для подражания: https://elib.belstu.by/bitstream/123456789/66626/3/%D0%9F%D0%BE%D0%BB%D0%BE%D0%B6%D0%B5%D0%BD%D0%B8%D0%B5%20%D0%BE%20%D0%9A%D0%9F%20%D0%91%D0%93%D0%A2%D0%A3%202024.pdf

*/

// TODO: проверить как правильно оформлять содержание (outline)
// TODO: чтобы маленькая таблица расширялась
// TODO: список использованных источников

// TODO: styles-debug: сделать предупреждения для неправильно оформленных списков
// TODO: styles-debug: сделать предупреждения для недостаточной заполненности страницы
// TODO: styles-debug: сделать предупреждения для русской «и», «щ» и «ъ» при беларусском языке, и для беларусской «Ў» при русском языке



#let font-size = 14pt;

// размер заголовков
#let font-heading-size = font-size;

// отступ между строк
#let line-indent = 6pt;

// отступ между абзацами такой-же, как отступ между строк
#let paragraph-spacing = line-indent;

// абзацный отступ
#let paragraph-indent = 12.5mm;

// отступ у заголовков такой-же как и абзацный отступ
#let heading-indent = paragraph-indent;

// отступ у списков такой-же как и абзацный отступ
#let list-indent = paragraph-indent;


#let spacing-gost-page-margin-left = 23mm;
#let spacing-gost-page-margin-right = 10mm;
#let spacing-gost-page-margin-top = 20mm;
#let spacing-gost-page-margin-bottom = 15mm;


// [ ]  8.3.1 Текст пояснительной записки разделяют на разделы и подразделы, а при необходимости – на пункты и подпункты в соответствии с ГОСТ 2.105 или ГОСТ 7.32.
// [ ]  8.3.2 Каждый раздел, подраздел и пункт должен иметь заголовок. Заголовки разделов, подразделов и пунктов записываются строчными буквами (кроме первой прописной) с абзацного отступа, равного 12,5 мм. Перенос слов в заголовках не допускается. Точку в конце заголовка не ставят. Если заголовок состоит из двух предложений, их разделяют точкой.
// [ ]  8.3.3 Заголовки разделов, подразделов и пунктов выполняются шрифтом основного текста и выделяются полужирным шрифтом. Заголовки разделов должны быть отделены от текста интервалом в 18 пт, заголовки подразделов и пунктов: сверху – интервалом в 18 пт, снизу – интервалом в 12 пт. Соседние, последовательно записанные заголовки раздела и подраздела следует отделять друг от друга интервалом 12 пт, а подраздела и пункта – интервалом 6 пт.
// [ ]  8.3.4 Подпункты заголовков не имеют и записываются текстом с абзацного отступа. Подпункты не разделяются между собой дополнительными интервалами.

#let spacing-gost_any-h1 = 0pt;
#let spacing-gost_h1-any = 18pt;

#let spacing-gost_any-h2 = 18pt;
#let spacing-gost_h2-any = 12pt;

#let spacing-gost_any-h3 = 18pt;
#let spacing-gost_h3-any = 12pt;

#let spacing-gost_any-h4 = 18pt;
#let spacing-gost_h4-any = 12pt;

#let spacing-gost_h1-h2 = 12pt;
#let spacing-gost_h2-h3 = 6pt;
#let spacing-gost_h3-h4 = 6pt; // сомнительный источник

#let place-spacing_h1-h2 = {}             // deprecated
#let spacing_h1-h2 = place-spacing_h1-h2; // deprecated
#let place-spacing_h2-h3 = {}             // deprecated
#let spacing_h2-h3 = place-spacing_h2-h3; // deprecated
#let place-spacing_h3-h4 = {}             // deprecated
#let spacing_h3-h4 = place-spacing_h3-h4; // deprecated

#let spacing-gost_any-figure = 14pt;
#let spacing-gost_figure-any = 14pt;


// deprecated
#let heading-unmarked(body) = align(center)[#heading(
  level: 1,
  numbering: none,
)[#body]];

// deprecated
#let heading-unlisted = heading-unmarked;

#let style-italze-latin(body) = {
  show regex("\p{script=Latin}+"): it => text(style: "italic")[#it.text]

  body
}




#let tr(ru, be) = context {
       if text.lang == "be" { be } 
  else if text.lang == "ru" { ru } 
  else { 
    panic("language \"" + text.lang + "\" is not supported")
  }
}

#let styles(content, italize-latin: false, lang: "ru") = {


  //---------- Общее ----------//

  if lang != "ru" and lang != "be" {
    panic("язык \"" + lang + "\" не поддерживается, используйте либо \"ru\" (русский), либо \"be\" (беларусский)");
  }

  set text(
    font: "Times New Roman",
    font-size,
    lang: lang,
    fallback: false, // false на случай если не будут найдены нужные глифы в шрифте или не найдётся шрифт — это будет ясно видно
    hyphenate: true, // Добавляет переносы слов
  );

  set page("a4", margin: (left: spacing-gost-page-margin-left, right: spacing-gost-page-margin-right, top: spacing-gost-page-margin-top, bottom: spacing-gost-page-margin-bottom), numbering: "1", number-align: right + top);

  set par(
    first-line-indent: (
      amount: paragraph-indent,
      all: true,
    ), // абзацный отступ
    
    leading: line-indent, // остступ между абзацных строк
    justify: true, // растягивание текста по всей ширине документа
    spacing: paragraph-spacing,
  );

  set page(numbering: "1");


  //---------- Содержание ----------//
  
  show outline: it => {
    show heading: set align(center)
    it
  }


  //---------- Перечисления ----------//

  let list-marker = [--]
  let body-indent = 2pt

  let enum-symbols = ("0", "а", "б", "в", "г", "д", "е", "ж", "и", "к", "л", "м", "н", "п", "р", "с", "т", "у", "ф", "х", "ц", "ч", "ш", "щ", "э", "ю", "я")
  let get-enum-symbol(n) = if n >= enum-symbols.len() { n - enum-symbols.len() + 1 } else { enum-symbols.at(n) }

  set list(marker: list-marker, body-indent: body-indent)
  set enum(numbering: n => [#get-enum-symbol(n))], body-indent: body-indent)

  let depth = state("belstu-gost_list-depth", 0) // общий для list и enum
  let enum-parents = state("belstu-gost_enum-parents", ())

  show list: it => context {
    let d = depth.get()
    let marker = if type(it.marker) == array {
      it.marker.at(calc.rem(d, it.marker.len()))
    } else if type(it.marker) == function {
      (it.marker)(d)
    } else { it.marker }

    let x = (d + 1) * paragraph-indent
    let hang = x + measure(marker).width + it.body-indent

    for item in it.children {
      block(spacing: if it.tight { par.leading } else { par.spacing })[
        #set par(hanging-indent: hang, first-line-indent: 0pt)
        #h(x)#marker#h(it.body-indent)#{
          depth.update(n => n + 1)
          item.body
          depth.update(n => n - 1)
        }
      ]
    }
  }

  show enum: it => context {
    let d = depth.get()
    let parents = enum-parents.get()
    let x = (d + 1) * paragraph-indent
    let n = if it.start == auto { 1 } else { it.start }

    for item in it.children {
      if item.has("number") and item.number != auto { n = item.number }
      let label = if it.full { numbering(it.numbering, ..parents, n) } else { numbering(it.numbering, n) }
      let hang = x + measure(label).width + it.body-indent
      let cur = n

      block(spacing: if it.tight { par.leading } else { par.spacing })[
        #set par(hanging-indent: hang, first-line-indent: 0pt)
        #h(x)#label#h(it.body-indent)#{
          depth.update(k => k + 1)
          enum-parents.update(a => { a.push(cur); a })
          item.body
          enum-parents.update(a => { let _ = a.pop(); a })
          depth.update(k => k - 1)
        }
      ]
      n += 1
    }
  }




  //---------- Разделы ----------//

  set heading(numbering: "1.1")
  show heading: set text(font-heading-size)

  // «Каждый раздел, подраздел и пункт должен иметь заголовок. Заголовки разделов, подразделов и пунктов записываются строчными буквами (кроме первой прописной) с абзацного отступа, равного 12,5 мм.» — стр. 14
  show heading: it => grid(columns: (paragraph-indent, 1fr), [], [#it]);

  // Не позволять переносить слова в заголовках
  show heading: set text(hyphenate: false);

  // 8.4 Структурным элементам «Титульный лист», «Задание на курсовой проект (курсовую работу)», «Реферат», «Оглавление», «Введение», «Заключение», «Список использованных источников», «Приложение» номера не присваиваются.
  let unnumbered-titles = (
    [Титульный лист],
    [Задание на курсовой проект],
    [Задание на курсовую работу],
    [Реферат],
    // [Оглавление],
    [Введение],
    [Заключение],
    [Список использованных источников],
    // [Приложение],
  )

  let unnumbered = unnumbered-titles
    .map(b => heading.where(body: b))
    .reduce((a, b) => a.or(b))

  show unnumbered: set heading(numbering: none, outlined: false)
  show unnumbered: it => {h(1fr);it.body;h(1fr)}
  // TODO: проверить, действительно ли нужно убирать такие заголовки из содержания (`outlined: false`)


  // отступы
  let before  = (spacing-gost_any-h1, spacing-gost_any-h2, spacing-gost_any-h3, spacing-gost_any-h4)
  let after   = (spacing-gost_h1-any, spacing-gost_h2-any, spacing-gost_h3-any, spacing-gost_h4-any)
  let between = (spacing-gost_h1-h2, spacing-gost_h2-h3, spacing-gost_h3-h4) // between.at(L - 2) для заголовка уровня L

  let prev-heading = state("belstu-gost_prev-heading", none)

  // объявлять ПОСЛЕ остальных show heading (выше по коду),
  // чтобы этот блок оборачивал результат остальных правил
  show heading: it => context {
    let L = calc.min(it.level, 4)
    let p = prev-heading.get()
    let above = if p != none and p == L - 1 { between.at(L - 2) } else { before.at(L - 1) }
    block(above: above, below: after.at(L - 1), sticky: true, it)
    prev-heading.update(L)
  }

  // любой не-заголовок означает, что заголовок уже не «предыдущий»
  show par:    it => { prev-heading.update(none); it }
  show figure: it => { prev-heading.update(none); it }
  show list:   it => { prev-heading.update(none); it }
  show enum:   it => { prev-heading.update(none); it }
  show raw.where(block: true): it => { prev-heading.update(none); it }
  show math.equation.where(block: true): it => { prev-heading.update(none); it }


  //---------- Изображения (figure) ----------//

  // Сброс счётчиков для figure и
  // перенос на новую страницу
  // у заголовков первого уровня. Это должно
  // находится после содержания, чтобы
  // само содержание не оставляло за собой пустую страницу
  show heading.where(level: 1): it => {
    counter(figure.where(kind: table)).update(0);
    counter(figure.where(kind: raw)).update(0);
    counter(figure.where(kind: image)).update(0);
    if counter("belstu-gost_headings").get().at(0) != 0 {
      pagebreak();
    }
    it;
    counter("belstu-gost_headings").step()
  };

  // Подписи у figure в формате   Фигура 1 — «Описание»
  set figure(numbering: (..num) => numbering("1.1", counter(heading).get().first(), num.pos().first()));
  show figure.caption: it => /*align(center)*/[#it.supplement #it.counter.display(it.numbering) -- #it.body];

  // 8.9.6 Иллюстрации отделяются от текста отступом 14 пт.
  show figure: it => {v(spacing-gost_any-figure - 6pt);it;v(spacing-gost_figure-any - 6pt);};
  // TODO: избавиться от магических чисел

  //---------- Картинки ----------//

  // Замена стандартного «Рис.» на «Рисунок»
  show figure.where(kind: image): set figure(supplement: tr[Рисунок][Малюнак]);


  // //---------- Таблицы ----------//

  // Отображение подписи к таблице сверху слева относительно самой таблицы
  show figure.where(kind: table): set figure.caption(position: top);

  // TODO: сделать нормальные отступы у подписи таблицы (узнать как они вообще дожны себя вести)
  show figure.caption.where(kind: table): it => {place[#it];v(14pt);}
  
  // //---------- Таблицы ----------//

  // show figure.where(kind: table): set figure.caption(position: top)
  // show figure.where(kind: table): set block(breakable: true)   // 8.11.8
  // show figure.where(kind: table): set align(left)              // 8.11.4

  // show table: set text(12pt)                                   // 8.11.7
  // show table: set par(first-line-indent: 0pt, justify: false)

  // // растянуть таблицу, у которой все столбцы auto, на всю ширину
  // show table: it => {
  //   let cols = it.columns
  //   if cols.all(c => c == auto) {
  //     let f = it.fields()
  //     let _ = f.remove("children")
  //     table(..it.children, ..f, columns: (1fr,) * cols.len())
  //   } else { it }
  // }
  



  //---------- Листинги ----------//

  // Отключение подсветки синтаксиса
  set raw(theme: none);
  
  // [из какого-то файла] При использовании листингов по тексту записки необходимо оформлять их в рамке, использовать шрифт Courier New, размер – 12 пт
  show raw.where(block: true): set text(12pt, font: "Courier New");

  // Чёрная рамка вокруг кода
  show raw.where(block: true): it => {
    align(left)[
      #block(width: 100%, inset: 10pt, stroke: black)[
        #it;
      ];
    ];
  };

  // Возможность разрыва raw между страницами
  show figure.where(kind: raw): set block(breakable: true)


  //---------- Список использованных источников (библиография) ----------//

  // TODO: сделать номральный стиль
  set bibliography(title: tr[Список использованных источников][], style: "gost-r-705-2008-numeric")


  //---------- Применение стилей ----------//
  
  let right-style_italize-latin(content) = if italize-latin { style-italze-latin(content); } else { content; }
  right-style_italize-latin(content);
}

//---------- Приложения ----------//

// 8.12.2 Каждое приложение должно начинаться с нового листа с
// указанием по центру вверху первого листа слова «ПРИЛОЖЕНИЕ»
// прописными буквами и иметь заголовок, который записывается ниже
// отдельной строкой строчными буквами (кроме первой прописной) с
// выравниванием по центру.
// Приложения обозначаются прописными буквами русского алфавита (за исключением Ё, З, Й, О, Ч, Ь, Ы, Ъ). Например, ПРИЛОЖЕНИЕ А.

#let show-appendices(additional-elements: ()) = {

  let appendix-symbols = "АБВГДЕЖИКЛМНПРСТУФХЦШЩЭЮЯ".clusters()
  let get-appendix-symbol(n) = {
    if n >= appendix-symbols.len() {
      return n - appendix-symbols.len() + 1;
    }
    return upper(appendix-symbols.at(n))
  }

  show figure: set block(breakable: true)
  
  for (i, appendix) in additional-elements.enumerate() {
    align(center)[#heading(
      level: 1,
      numbering: none,
      supplement: [Приложение],
      [ПРИЛОЖЕНИЕ #get-appendix-symbol(i)],
    )]
    appendix
  }
}



//---------- Отладка ----------//

#let styles-debug(content, italize-latin: false, lang: "ru") = {

  let thickness = 1pt

  let color-info = silver;
  let color-warn = yellow;
  let color-err = red;

  // show text: it => context {
  //   let size = measure(it);
  //   box(place(rect(stroke: blue, width: size.width, height: -size.height)))
  //   it;
  // };

  set page(
    background: [#{
      set text(8pt, fill: color-info)
      
      place(dx: spacing-gost-page-margin-left, dy: spacing-gost-page-margin-top)[#{
        rect(
          stroke: thickness + color-info,
          width: 100% - (spacing-gost-page-margin-left + spacing-gost-page-margin-right),
          height: 100% - (spacing-gost-page-margin-top + spacing-gost-page-margin-bottom),
        );
      }];

      // абзацный отступ
      let global-paragraph-indent = spacing-gost-page-margin-left + paragraph-indent;
      place()[#{
        line(
          stroke: thickness + color-info,
          start: (global-paragraph-indent, 0%),
          end: (global-paragraph-indent, 100%),
        );  
      }];
      place(dx: global-paragraph-indent)[
        абзацный отступ \
        #paragraph-indent.mm()mm
      ];

      // центр рабочей области по горизонтали
      let workarea-center = (100% - spacing-gost-page-margin-bottom - spacing-gost-page-margin-top) * 0.5  +  spacing-gost-page-margin-top;
      place()[#{
        line(
          stroke: thickness + color-info,
          start: (0%, workarea-center),
          end: (100%, workarea-center),
        );  
      }];
      place(dy: workarea-center)[
        центр
      ];

    }]
  );


  // зазор между концом предыдущего элемента и началом этого

  let dbg-prev = state("belstu-gost_elements-spacing-debug", none)

  let dbg-wrap(it) = block(breakable: true, spacing: paragraph-spacing, {
    context {
      let prev = dbg-prev.get()
      let cur = here().position()   // теперь это реальный верх элемента
      if prev != none and prev.page == cur.page {
        let gap = cur.y - prev.y
        if gap >= 0pt {
          place(
            dx: -cur.x + paragraph-indent + 2*thickness,
            dy: -gap,
            box(width: spacing-gost-page-margin-left, height: gap,
              stroke: (right: color-info + thickness), inset: (right: 3.5*thickness),
              align(horizon + right, text(8pt, fill: color-info, weight: "regular")[#calc.round(gap.pt(), digits: 1)pt])),
          )
        }
      }
    }
    it
    context dbg-prev.update(here().position())   // теперь это реальный низ элемента
  })

  show heading: dbg-wrap
  show figure: dbg-wrap
  show par: dbg-wrap


  // стандартные стили

  styles(content, italize-latin: italize-latin, lang: lang);
}



//---------- Стилизированное отображение ----------//

// числа
#let style-number(number, digits: 3, scientific: false) = {
  if scientific {
    let sig = digits + 1
    // Handle zero
    if number == 0 { return [$0$] }

    let s = if number < 0 { "-" } else { "" }
    let a = calc.abs(number)
    // exponent = floor(log10(a))
    let e = calc.floor(calc.ln(a) / calc.ln(10))
    let m = a / calc.pow(10, e)

    // round mantissa to `sig` significant digits
    // shift = number of digits before decimal in mantissa (0..)
    let shift = calc.floor(calc.ln(m) / calc.ln(10)) + 1
    let factor = calc.pow(10, (sig - shift))
    let mant = calc.round(m * factor) / factor

    // if rounding pushes mant >= 10, adjust
    if mant >= 10 {
      mant = mant / 10
      e = e + 1
    }

    // format mantissa: remove trailing zeros
    let mant-s = str(mant)
    if mant-s.contains(".") {
      while mant-s.ends-with("0") { mant-s = mant-s.slice(0, mant-s.len() - 1) }
      if mant-s.ends-with(".") { mant-s = mant-s.slice(0, mant-s.len() - 1) }
    }
    mant-s = mant-s.replace(".", ",")

    return [$#s #mant-s dot 10^#text[#str(e)]$]
  }

  let number = calc.round(number, digits: digits)
  let sign = if number < 0 { "-" } else { "" }
  let a = calc.abs(number)
  let int-part = calc.floor(a)
  let frac = a - int-part

  sign
  str(int-part)
  if frac != 0 {
    ","
    str(calc.round(frac, digits: digits)).replace("0.", "")
  }
}

// deprecated
#let style-number-scientific(number, digits: 3) = style-number(number, digits: digits, scientific: true)


// отображение даты
#let style-date(date, month-as-number: true) = {
  // TODO: парсить date как строку и проверять существует ли такая дата
  if type(date) != datetime {
    panic("Тип переменной date должен быть datetime!");
  }
  if month-as-number {
    date.display("[day].[month].[year]");
  } else {
    str(date.day());
    " ";
           if date.month() ==  1 { tr([января],   [студзеня]);
    } else if date.month() ==  2 { tr([февраля],  [лютага]);
    } else if date.month() ==  3 { tr([марта],    [сакавіка]);
    } else if date.month() ==  4 { tr([апреля],   [красавіка]);
    } else if date.month() ==  5 { tr([мая],      [мая]);
    } else if date.month() ==  6 { tr([июня],     [чэрвеня]);
    } else if date.month() ==  7 { tr([июля],     [ліпеня]);
    } else if date.month() ==  8 { tr([августа],  [жніўня]);
    } else if date.month() ==  9 { tr([сентября], [верасня]);
    } else if date.month() == 10 { tr([октября],  [кастрычніка]);
    } else if date.month() == 11 { tr([ноября],   [лістапада]);
    } else if date.month() == 12 { tr([декабря],  [снежня]);
    }
    " ";
    str(date.year());
  }
}



//---------- Рамки ----------//

#let idef-frame(body, width: 100%, height: 10cm, author: none, date: auto, project: none, node-name: "A0", name: none) = block(stroke: black, width: width, height: height)[#{
  context {
  show grid: set text(6pt);
  set grid(align: left);

  let display-date;
  if date == auto { display-date = datetime.today(); } else { display-date = date; }
  display-date = style-date(display-date, month-as-number: false)
  // let content = scale(x: 50%, y: 50%, reflow: true)[#body];
  let content = grid(columns: (width), rows: (height/1.5), stroke: black, align: center, body);
  let body-height = measure(content).height;
  let header-height = (height - body-height)/2;

  grid(stroke: black, rows: (header-height), columns: (0.8fr, 1.5fr, 1fr, 1fr, 1fr), 
    table(columns: (1fr), rows: (1fr), 
      [ИСПОЛЬЗУЮТСЯ:]
    ),
    table(stroke: none, columns: (1fr, 1fr), [АВТОР:\ #author], rows: (auto, auto, 1fr), 
      [
        ДАТА: #display-date
      ], 
      table.cell(colspan: 2)[ПРОЕКТ:\ #project], 
      table.cell(colspan: 2, align: bottom)[ЗАМЕЧАНИЯ: ]
    ),
    table(columns: (header-height/4, 1fr), rows: (1fr, 1fr, 1fr, 1fr),
      table.cell(fill: black)[], [РАБОЧАЯ ВЕРСИЯ],
      table.cell(fill: none )[], [ЭСКИЗ],
      table.cell(fill: none )[], [РЕКОМЕНДОВАНО],
      table.cell(fill: none )[], [ПУБЛИКАЦИЯ],
    ),
    table(columns: (1fr, auto), rows: (1fr, 1fr, 1fr, 1fr), stroke: none,
      [ЧИТАТЕЛЬ], [ДАТА],
      table.hline(),
      [],         [],
      table.hline(),
      [],         [],
      table.hline(),
      [],         [],
    ),
    table(columns: (1fr), rows: (1fr, auto, 1fr), stroke: none,
      [КОНТЕКСТ], 
      table.cell(align: center)[
        #block(fill: gray, stroke: black.lighten(50%), width: 5mm, height: 3mm)
      ],
      [],
    ),
  );
  
  v(-6pt);
  content
  v(-6pt);
  
  grid(stroke: black, rows: ((height - body-height)/2), columns: (0.75fr, 1.5fr, 1fr),
    table(columns: (1fr), rows: (1fr, auto, 1fr), stroke: none,
      [УЗЕЛ:], 
      table.cell(align: center)[
        #node-name
      ],
      [],
    ),
    table(columns: (1fr), rows: (1fr, auto, 1fr), stroke: none,
      [НАЗВАНИЕ:], 
      table.cell(align: center)[
        #name
      ],
      [],
    ),
    table(columns: (1fr), rows: (1fr, auto, 1fr), stroke: none,
      [НОМЕР:], 
      table.cell(align: center)[
        
      ],
      table.cell(inset: 0pt, align: right)[
        #box(stroke: black, height: 100%, width: 30%)[#v(1fr);#h(2pt);Стр:#h(1fr);#v(1fr);]
      ],
    ),
  );

  }
}]




//---------- Макеты страниц ----------//

// Титульная страница
#let simple-title-page-belstu(
  name: "Название предмета",
  student: [Иванов~И.~И.],
  teacher: [Иванов~И.~И.],
  faculty: [ФИТ],
  course: 1,
  group: 1,
  city: auto,
  year: auto) = page(numbering: none)[
    
  // Чтобы первая строка «Студент: ...» не улетала вправо
  #set par(first-line-indent: (amount: paragraph-indent, all: false));
  #align(center)[
    #tr[Учреждение образования][Установа адукацыі] \
    #tr["БЕЛОРУССКИЙ ГОСУДАРСТВЕННЫЙ\ ТЕХНОЛОГИЧЕСКИЙ УНИВЕРСИТЕТ"]["БЕЛАРУСКІ ДЗЯРЖАЎНЫ\ ТЭХНАЛАГІЧНЫ УНІВЕРСІТЭТ"]
  ]
  #v(4fr)
  #align(center)[
    *#name*
  ]
  #v(4fr)
  #align(right)[
    #align(right, block[
      #align(left)[
        #tr[Студент][Студэнт]: #student \
        #faculty #course #tr[курс][курс] #group #tr[группа][група] \
        #tr[Преподаватель][Выкладчык]: #teacher \
      ]
    ])
  ]
  #v(3fr)
  #align(center)[
    #if city == auto {tr[Минск][Мінск]} else {city}
    #if year == auto [
      #datetime.today().display("[year]")
    ] else [
      #year
    ]
  ]
];

// для обратной совместимости
#let simple-title-page-bstu = simple-title-page-belstu;





// шорткат:
// #block(width: 100%, height: 50%, below: 0fr)[
//   #set par(first-line-indent: 1.5cm);
//   #set text(14pt);
//   #align(right, block(width: 50%)[#align(left)[
//     Декану \
//     Факультета Информационных Технологий \
//     Иванову И. И. \
//     студента 4 курса 2 группы \
//     Иванова И. И.
//   ]])
//   #v(1cm);
//   #align(center)[Заявление]
//   #v(0.5cm);

//   Прошу разрешить отработать лабораторную работу по предмету «предмет» (преподаватель Иванов И. И.), пропущенную #gost.style-date(datetime(year: 2000, month: 01, day: 01)) без уважительной причины.

//   Документ об оплате ликвидации академической задолженности прилагаю или предоставляю
  
//   #h(-0.5cm); #gost.style-date(datetime.today()); #h(1fr); #underline(extent: 1cm)[#text(10pt, baseline: 10pt, fill: black)[#h(1cm)подпись#h(1cm)]]; #h(1cm);
// ]

#let document-application-for-lab-retake-item(lesson, teacher, dates, reason-document-name) = {
  if type(lesson) != str { panic("variable 'lesson' must be a string"); }
  if type(teacher) != str { panic("variable 'teacher' must be a string"); }
  if type(reason-document-name) != str and reason-document-name != none { panic("variable 'reason-document-name' must be a string or none"); }
  if dates.any(date => type(date) != datetime) { panic("variable 'dates' must be an array of datetimes"); }

  return (
    lesson: lesson,
    teacher: teacher,
    dates: dates,
    reason-document-name: reason-document-name,
  )
};

/// Генерирует заявление на отработку пропущенной лабораторной работы
/// 
/// - student-sex: Пол студента. Либо "male", либо "female"
/// - from-student (str): ФИО студента в родительном (нету кого? чего?) падеже. Например "Иванова И. И."
/// - of-faculty (str): Название факультета в родительном (нету кого? чего?) падеже. Например "факультета информационных технологий", "лесохозяйственного факультета"
/// - to-dean (str): ФИО декана в дательном (дать кому? чему?) падеже. Например: "Иванову И. И."
/// - course (int): Номер курса
/// - group (int): Номер группы
/// - application-date (datetime): Дата заявления (по умолчанию сегодняшняя дата)
/// - items (array): Список с информацией про пропуски. Можно сгенерировать с помощью функции `document-application-for-lab-retake-item`
/// - many-dates-means-many-applications (bool): если true, то если в item есть много дат, то не записывать в одно заявление все эти даты, а генерировать по одному заявлению на каждую дату (по умолчанию false)
/// - block-height (str): Высота блока (по умолчанию "50%")
/// 
/// -> content
#let document-application-for-lab-retake(student-sex, from-student, of-faculty, to-dean, course, group, items, application-date: auto, many-dates-means-many-applications: false, block-height: 50%) = page(numbering: none)[#{

  if many-dates-means-many-applications {
    let new-items = ();

    for item in items {
      for date in item.dates {
        new-items.push(document-application-for-lab-retake-item(item.lesson, item.teacher, (date,), item.reason-document-name));
      }
    }

    items = new-items;
  }

  for item in items {
    block(width: 100%, height: block-height, below: 0fr)[
      #set par(first-line-indent: 1.5cm);
      #set text(14pt);
      #align(right, block(width: 50%)[#align(left)[
        #tr[Декану][Дэкану] \
        #of-faculty \
        #to-dean \
        #if student-sex == "male" [#tr[студента][студэнта]] else if student-sex == "female" [#tr[студентки][студэнткі]] else {panic()}
        #course #tr[курса][курса] #group #tr[группы][групы] \
        #from-student
      ]])
      #v(1cm);
      #align(center)[#tr[Заявление][Заява]]
      #v(0.5cm);

      #tr[Прошу разрешить отработать][Прашу дазволіць адпрацаваць] #if item.dates.len() > 1 [#tr[лабораторные работы][лабараторныя работы]] else [#tr[лабораторную работу][лабараторную работу]] #tr[по предмету][па прадмеце] «#item.lesson» (#tr[преподаватель][выкладчык] #item.teacher), #if item.dates.len() > 1 [#tr[пропущенные][прапушчаныя]] else [#tr[пропущенную][прапушчаную]] #for date in item.dates { if item.dates.first() != date [, ]; style-date(date); } #if item.reason-document-name == none [
        #tr[без уважительной причины.][без паважлівай прычыны.]

        #tr[Документ об оплате ликвидации академической задолженности прилагаю или предоставляю][Дакумент аб аплаце ліквідацыі акадэмічнай запазычанасці дадаю або прадастаўлю]
      ] else [
        #tr[по уважительной причине.][па паважлівай прычыне.]

        #tr[Приложение][Дадатак]: #item.reason-document-name
      ]
      #v(0.5cm);

      #h(-0.5cm); #style-date(if application-date == auto {datetime.today()} else {application-date}); #h(1fr); #underline(extent: 1cm)[#text(10pt, baseline: 10pt, fill: black)[#h(1cm)#tr[подпись][подпіс]#h(1cm)]]; #h(1cm);
    ]
  }
}];



