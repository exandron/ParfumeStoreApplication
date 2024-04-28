<#import "blocks/template.ftlh" as t>
<@t.template user>
    <div class="card">
        <div class="card-header">
            КОНТАКТЫ
        </div>
        <div class="card-body">
            <blockquote class="blockquote mb-0">
                <div class="row">
                    <div class="col">
                        <p>Добро пожаловать в мир парфюмерных шедевров от лучших мастеров индустрии красоты!</p>
                        <br>
                        <p>В интернет-магазине https://perfumestore.by/ и
                            офлайн-магазинах "PerfumeStore" представлена самая широкая
                            в Беларуси коллекция артистической парфюмерии.</p>
                        <br>
                        <p>Время работы менеджера интернет-магазина: понедельник-пятница с 9:00 до 18:00.
                            По всем интересующим вопросам звоните +375 (29) 126 38 48
                            или пишите на электронную почту perfumestore@gmail.com.</p>
                        <br>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <img class="w-100" src="/static/images/shop1.jpg">
                        </div>
                        <div class="col-6">
                            <img class="w-100" src="/static/images/shop2.jpg">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <p>ПР. ПОБЕДИТЕЛЕЙ, 65</p>
                            <p> ТЦ “ЗАМОК”, 2-Й ЭТАЖ</p>
                            <p> M: +375 29 1054056</p>
                            <p> Время работы: 10:00 - 22:00</p>
                        </div>
                        <div class="col-6">
                            <p>ПР. ПОБЕДИТЕЛЕЙ, 9</p>
                            <p> ТРЦ “GALLERIA MINSK”, 1-Й ЭТАЖ</p>
                            <p> M: +375 29 1112576</p>
                            <p> Время работы: 10:00 - 22:00</p>
                        </div>
                    </div>
                    <br><br>
                    <p><h3>Где мы находимся?</h3></p>
                    <br>
                    <div class="row">
                        <div id="map" style="width: 100%; height: 400px;"></div>
                    </div>
                </div>

            </blockquote>
        </div>
    </div>
    <br>
</@t.template>