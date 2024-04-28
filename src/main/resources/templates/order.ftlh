<#import "blocks/template.ftlh" as t>
<@t.template user>

    <div class="card">
        <h1 style="text-align: center">Оформление заказа</h1>
        <hr>
        <form action="/order/${cart.id}" method="post" class="d-inline">
            <div class="row">
                <div class="col-5 ml-5 mr-5">
                    <br>
                    <h4 style="text-align: left">Варианты доставки</h4>
                    <input type="radio" class="btn-check" name="options" id="btn-check-1-outlined" autocomplete="off" value="pickup">
                    <label class="btn btn-outline-secondary" for="btn-check-1-outlined" style="border-radius: 0">
                        <div class="row">
                            <div class="col-2 ml-4">
                                <img src="/static/images/pickup.png" class="img-fluid" style="width: 100%;">

                        </div>
                        <div class="col-9">
                                    <b>Самовывоз из магазина</b>
                                    <br>Вы можете самостоятельно забрать заказ из одного из наших магазинов
                        </div>
                    </div>
                    </label>
                    <br>
                    <input type="radio" class="btn-check" name="options" id="btn-check-2-outlined" autocomplete="off">
                    <label class="btn btn-outline-secondary" for="btn-check-2-outlined" style="border-radius: 0">
                        <div class="row">
                            <div class="col-2 ml-4">
                                <img src="/static/images/courierMinsk.png" class="card-img-top" style="border-radius: 0">
                            </div>
                            <div class="col-9">
                                <b>Курьерская служба по Беларуси</b>
                                <br>Стоимость - 10р. При заказе на сумму свыше 600р доставка бесплатная.
                            </div>
                        </div>
                    </label>
                    <br><br>
                    <div class="form-group">
                        <label for="payment">Способ оплаты</label>
                        <select id="payment" name="payment" class="form-control" required>
                            <option value="">Способ оплаты не выбран</option>
                            <option value="Наличными">Наличными</option>
                            <option value="Картой при получении">Картой при получении</option>
                        </select>
                    </div>
                    <br>
                    <div class="form-group">
                        <label for="orderComment">Комментарий к заказу</label>
                        <textarea class="form-control" id="orderComment" name="orderComment"></textarea>
                    </div>
                </div>
                <div class="col-5 ml-5 mr-5">
                    <br>
                    <h4 style="text-align: left">Информация о доставке</h4>
                    <div id="dropdown1" style="display: none;">
                        <div class="form-group">
                            <label for="offlineShop">Магазин самовывоза</label>
                            <select class="form-control" name="offlineShop" id="offlineShop">
                                <option value="">Магазин не выбран</option>
                                <option value='Пр.Победителей, 9, ТРЦ "Галерея"'>Пр.Победителей, 9, ТРЦ "Галерея"</option>
                                <option value='Пр.Победителей, 65, ТЦ "Замок"'>Пр.Победителей, 65, ТЦ "Замок"</option>
                            </select>
                        </div>
                    </div>
                    <div id="dropdown2"  style="display: none;">
                        <div class="form-group">
                            <label for="city">Город</label>
                            <input type="text" class="form-control" id="city" name="city">
                        </div>
                        <div class="form-group">
                            <label for="street">Улица</label>
                            <input type="text" class="form-control" id="street" name="street">
                        </div>
                        <div class="row">
                            <div class="col-5 mr-1">
                                <label for="houseNumber">Номер дома</label>
                                <input type="number" class="form-control" id="houseNumber" name="houseNumber">
                            </div>
                            <div class="col-5">
                                <label for="apartmentNumber">Квартира</label>
                                <input type="number" class="form-control" id="apartmentNumber" name="apartmentNumber">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-5 mr-1">
                                <label for="floor">Этаж</label>
                                <input type="number" class="form-control" id="floor" name="floor">
                            </div>
                            <div class="col-5">
                                <label for="entrance">Подъезд</label>
                                <input type="number" class="form-control" id="entrance" name="entrance">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <br><br>
            <div class="row">
                <div class="col-md-11 ml-5">
                    <table class="table table-hover table-secondary">
                        <thead>
                        <tr>
                            <th scope="col" class="col-2" style="vertical-align: middle; text-align: center;">Товары</th>
                            <th scope="col" class="col-3" style="vertical-align: middle; text-align: center;">Название</th>
                            <th scope="col" class="col-3" style="vertical-align: middle; text-align: center;">Цена</th>
                            <th scope="col" class="col-2" style="vertical-align: middle; text-align: center;">Количество</th>
                            <th scope="col" class="col-2" style="vertical-align: middle; text-align: center;"></th>
                        </tr>
                        </thead>
                        <tbody>
                        <#list cartProducts as cartProduct>
                            <tr>
                                <td class="col-2">
                                    <a href="/product/${cartProduct.product.id}" class="product-link">
                                        <div>
                                            <img src="/images/${cartProduct.product.previewImageId}" class="card-img-top square-image img-thumbnail" style="width: 150px;">
                                        </div>
                                    </a>
                                </td>
                                <td class="col-3" style="vertical-align: middle; text-align: center;">${cartProduct.product.title}</td>
                                <td class="col-3" style="vertical-align: middle; text-align: center;">${cartProduct.product.price} РУБ.</td>
                                <td class="col-2" style="vertical-align: middle; text-align: center;">${cartProduct.quantity}</td>
                                <td class="col-2" style="vertical-align: middle; text-align: center;">
                                    <form action="/cart/delete/${cartProduct.product.id}" method="post" class="d-inline">
                                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                        <button type="submit" class="btn btn-outline-dark rounded-0">
                                            Удалить
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        <#else>
                            <tr>
                                <td colspan="3">
                                    <h3>Товаров нет</h3>
                                </td>
                            </tr>
                        </#list>
                        </tbody>
                    </table>
                </div>
            </div>
            <hr>
            <div class="row">
                <div class="col-md-8">
                </div>
                <div class="col-md-4">
                    <h3 style="text-align: right">Итого: ${totalPrice} РУБ.</h3>
                    <br><br>
                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                            <div class="d-grid gap-2">
                                <button class="btn btn-outline-dark rounded-0" type="submit">
                                    Оформить заказ
                                </button>
                            </div>
                    <br><br>
                </div>
            </div>
        </form>
    </div>
    <br><br>

    <script>
        // Обработчик события загрузки страницы
        window.addEventListener('load', function() {
            // Получаем радиокнопку и выпадающий список по их идентификаторам
            const radioBtn1 = document.getElementById('btn-check-1-outlined');
            const radioBtn2 = document.getElementById('btn-check-2-outlined');

            const dropdown1 = document.getElementById('dropdown1');
            const dropdown2 = document.getElementById('dropdown2');

            const offlineShop = document.getElementById('offlineShop');
            const city = document.getElementById('city');
            const street = document.getElementById('street');
            const houseNumber = document.getElementById('houseNumber');
            const apartmentNumber = document.getElementById('apartmentNumber');
            const floor = document.getElementById('floor');
            const entrance = document.getElementById('entrance');

            // Слушаем событие изменения состояния радиокнопки
            radioBtn1.addEventListener('change', function() {
                // Если радиокнопка выбрана, показываем выпадающий список
                if (this.checked) {
                    dropdown1.style.display = 'block';
                    dropdown2.style.display = 'none';
                    dropdown3.style.display = 'none';
                    offlineShop.required = true;

                    city.required = false;
                    street.required = false;
                    houseNumber.required = false;
                    apartmentNumber.required = false;
                    floor.required = false;
                    entrance.required = false;
                } else {
                    dropdown1.style.display = 'none';
                }
            });

            radioBtn2.addEventListener('change', function() {
                // Если радиокнопка выбрана, показываем выпадающий список
                if (this.checked) {
                    dropdown2.style.display = 'block';
                    dropdown1.style.display = 'none';
                    dropdown3.style.display = 'none';
                    city.required = true;
                    street.required = true;
                    houseNumber.required = true;
                    apartmentNumber.required = true;
                    floor.required = true;
                    entrance.required = true;
                    offlineShop.required = false;
                } else {
                    dropdown2.style.display = 'none';
                }
            });
        });
    </script>
</@t.template>