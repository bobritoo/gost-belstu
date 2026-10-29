#import "@local/gost-belstu:0.0.8" as gost

#show: it => gost.styles(it, italize-latin: false);

#gost.simple-title-page-belstu();

#outline()

= Введение

#lorem(237)

= Раздел

== Подраздел

#lorem(56)

#figure(
    table(columns: 4,
        ..range(8).map(i => lorem(3))
    ),
    caption: "Таблица",
)

#lorem(66)

#figure(
    box(width: 115mm, height: 56mm, stroke: black),
    caption: "Рисунок",
)


#lorem(66)

#figure(
    ```c
    getRandomNumber() {
        return 4;
        // chosen by fair dice roll
        // guaranteed to be random
    };
    ```,
    caption: "Листинг",
)

== Подраздел

#lorem(237)

= Заключение

#lorem(237)

#gost.show-appendices(additional-elements: range(4).map(i =>
    figure(
        ```c
        getRandomNumber() {
            return 4;
            // chosen by fair dice roll
            // guaranteed to be random
        };
        ```,
        caption: "Листинг",
    )
))
