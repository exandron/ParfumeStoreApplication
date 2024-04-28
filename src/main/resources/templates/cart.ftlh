<#import "blocks/template.ftlh" as t>
<@t.template user>

    <h1 style="text-align: center">Корзина</h1>
    <hr>
    <div class="card">
        <div class="row">
            <div class="col-12">
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
<#--                                    <div class="card text-white bg-dark my-3 product">-->
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
                            <td colspan="5">
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
                <form method="get" action="/order">
                    <!-- Ваши другие поля формы -->
                    <div class="d-grid gap-2">
                        <button class="btn btn-outline-dark rounded-0" type="submit">
                            Перейти к оформлению
                        </button>
                    </div>
                </form>
                <br><br>
            </div>
        </div>
    </div>
    <br><br>
</@t.template>