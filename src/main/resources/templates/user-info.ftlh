<#import "blocks/template.ftlh" as t>
<@t.template userByPrincipal>
    <h2 style="text-align: center">Информация о пользователе</h2>
    <hr>
    <div style="text-align: center">
        <img src="/static/images/avatar.png"
             style="border:2px solid black; border-radius: 20px" height="120">
        <br>
        <br>
        <h2>${user.name}</h2>
        <br>
        Электронная почта: <b>${user.email}</b>
        <br>
        Номер телефона: <b>${user.phoneNumber}</b>
    </div>
    <br>
    <hr>
    <h3 style="text-align: center">Заказы пользователя ${user.name}</h3>
<#--    <div class="card-columns">-->
<#--        <#list products as product>-->
<#--            <a href="/product/${product.id}" class="product-link">-->
<#--                <div class="card text-white bg-dark my-3 product">-->

<#--                    <img src="/images/${product.previewImageId}"-->
<#--                         class="card-img-top">-->
<#--                    <div class="card-body">-->
<#--                        <h5 class="card-title">${product.title}</h5>-->
<#--                        <p class="card-text">${product.price} ₽</p>-->
<#--                    </div>-->
<#--                    <div class="card-footer">-->
<#--                        ${product.user.name}-->
<#--                    </div>-->
<#--                </div>-->
<#--            </a>-->
<#--        <#else>-->
<#--            <h1 style="text-align: center">Не найдено</h1>-->
<#--        </#list>-->
<#--    </div>-->
    <div class="card">
    <div class="row">
        <div class="col-12">
            <table class="table table-hover table-secondary">
                <thead>
                <tr>
                    <th scope="col" class="col-2" style="vertical-align: middle; text-align: center;">Дата заказа</th>
                    <th scope="col" class="col-2" style="vertical-align: middle; text-align: center;">Статус</th>
                    <th scope="col" class="col-3" style="vertical-align: middle; text-align: center;">Адрес</th>
                    <th scope="col" class="col-2" style="vertical-align: middle; text-align: center;">Способ оплаты</th>
                    <th scope="col" class="col-2" style="vertical-align: middle; text-align: center;">Товары</th>
                    <th scope="col" class="col-1" style="vertical-align: middle; text-align: center;">Количество</th>
                </tr>
                </thead>
                <tbody>
                <#list orders as order>
                    <tr>
                        <td class="col-2" style="vertical-align: middle; text-align: center;">${order.orderDate}</td>
                        <td class="col-2" style="vertical-align: middle; text-align: center;">${order.status}</td>
                        <td class="col-3" style="vertical-align: middle; text-align: center;">
                            <#if order.address.street == 'Пр.Победителей, 65, ТЦ "Замок"' || order.address.street == 'Пр.Победителей, 9, ТРЦ "Галерея"'>
                                Самовывоз на адрес:
                                <br>
                                ${order.address.street}
                            <#else>
                                Курьерская доставка:
                                <br>
                                ${order.address.city}
                                <br>
                                ${order.address.street}, ${order.address.houseNumber}
                                <br>
                                Этаж: ${order.address.floor}, Подъезд:  ${order.address.entrance}
                            </#if>
                        </td>
                        <td class="col-2" style="vertical-align: middle; text-align: center;">${order.paymentMethod}</td>
                        <td class="col-2" style="vertical-align: middle; text-align: center;">
                            <ul>
                                <#list order.orderProducts as orderProduct>
                                    <a href="/product/${orderProduct.product.id}" class="product-link">
                                        <li>${orderProduct.product.title}</li>
                                    </a>
                                </#list>
                            </ul>
                        </td>
                        <td class="col-1" style="vertical-align: middle; text-align: center;">
                            <ul>
                                <#list order.orderProducts as orderProduct>
                                    <li>${orderProduct.quantity}</li>
                                </#list>
                            </ul>
                        </td>
                    </tr>
                <#else>
                    <tr>
                        <td colspan="6">
                            <h3>Заказов нет</h3>
                        </td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </div>
    </div>
    <br><br>
</@t.template>