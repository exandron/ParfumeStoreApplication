<#macro template user>
    <!doctype html>
    <html lang="ru">
        <head>
            <!-- Required meta tags -->
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
            <link rel="stylesheet" href="/static/css/style.css">

            <!-- Bootstrap CSS -->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"
                  integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn"
                  crossorigin="anonymous">

            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.0/css/bootstrap.min.css">
            <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.0/js/bootstrap.bundle.min.js"></script>

            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </head>
    <body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="/">Главная</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                <div class="navbar-nav">
                    <a class="nav-link" href="/contact-page">Наши магазины</a>
                    <a class="nav-link" href="/about-page">О нас</a>
                </div>
            </div>
            <div class="d-flex justify-content-end">
                <#if user.email??>
                    <div class="dropdown text-end">
                        <a href="/profile">
                            <img src="/static/images/avatar.png" alt="mdo"
                                 width="32" height="32" class="rounded-circle">
                        </a>
                    </div>
                <#else>
                    <button class="btn btn-light my-2 my-sm-0" type="button"
                            onclick="window.location.href = '/login'">
                        Войти
                    </button>
                </#if>
            </div>
        </div>
    </nav>


        <div class="container mt-4 pr-5">
            <#nested/>
        </div>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
                integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
                crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
                integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
                crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"
                integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T"
                crossorigin="anonymous"></script>
        <script>

            $(document).ready(function() {
                $('.carousel').carousel({
                    interval: 3000, // Интервал между слайдами (в миллисекундах)
                    pause: 'hover', // Пауза при наведении курсора
                    wrap: true // Зациклить карусель
                });
            });
        </script>
        <script src="https://api-maps.yandex.ru/2.1/?apikey=9816f426-34a1-45f1-ad99-218cf3bcbe96&lang=ru_RU" type="text/javascript"></script>
        <script type="text/javascript">
            ymaps.ready(function () {
                var map = new ymaps.Map('map', {
                    center: [53.910086, 27.566262], // Координаты центра карты в Минске
                    zoom: 10 // Уровень масштабирования карты
                });

                var placemark = new ymaps.Placemark([53.908554, 27.548699], {
                    hintContent: 'Метка на карте', // Всплывающая подсказка при наведении на метку
                    balloonContent: 'Пр. Победителей, 9. ТРЦ "GALLERIA MINSK", 1-й этаж' // Содержимое балуна (всплывающей подсказки) при клике на метку
                });

                var placemark1 = new ymaps.Placemark([53.92631, 27.51762], {
                    hintContent: 'Метка на карте', // Всплывающая подсказка при наведении на метку
                    balloonContent: 'Пр. Победителей, 65. ТЦ "Замок", 2-й этаж' // Содержимое балуна (всплывающей подсказки) при клике на метку
                });

                map.geoObjects.add(placemark);
                map.geoObjects.add(placemark1);
            });
        </script>


    </body>
</html>
</#macro>