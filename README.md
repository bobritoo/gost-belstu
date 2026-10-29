## Что это?

Это стили для [Typst](https://typst.app/) для Белорусского Государственного Технологического Университета.

Это не официальный репозиторий, тут могут быть ошибки и несостыковочки.

## Как установить?

### Шрифты

По ГОСТу вам нужны будут шрифты `Times New Roman` и `Courier New`.

### Пакет

Файл `gost-belstu.typ` можно просто скопировать куда угодно – у него нет зависимостей. Ещё есть скрипт для установки `install.sh`, он положит всё на свои места.

**К сожалению скрипта установки для Windows сейчас тут нету (можете предложить свой вариант).**

Клонируйте репозиторий, запустите скрипт установки (просто копирует файлы в нужное место):
```sh
git clone --depth 1 https://github.com/bobritoo/gost-belstu.git
cd gost-belstu
./install.sh
```

Или просто скачать один файл:
```sh
wget https://raw.githubusercontent.com/bobritoo/gost-belstu/refs/heads/main/gost-belstu.typ
```

## Как использовать?

Чтобы применить стили, подключите эту библиотеку и передайте всё содержимое документа функции `styles` (`#show: it => gost.styles(it)`), вот:
```typ
#import "@local/gost-belstu:0.0.8" as gost
// или если вы скачивли файл:
// #import "gost-belstu.typ" as gost

#show: it => gost.styles(it);
// для отладки можно использовать:
// #show: gost.styles-debug
```
