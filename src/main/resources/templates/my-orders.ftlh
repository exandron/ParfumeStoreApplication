<#import "blocks/template.ftlh" as t>
<@t.template user>
    <h1 style="text-align: center">Мои заказы</h1>
    <hr>
    <div class="card">
        <form action="/order/printOrders" method="get" class="d-inline">
            <div class="row">
                <div class="col-12">
                    <table class="table table-hover table-secondary">
                        <thead>
                        <tr>
                            <th scope="col" class="col-2" style="vertical-align: middle; text-align: center;">Дата заказа</th>
                            <th scope="col" class="col-2" style="vertical-align: middle; text-align: center;">Статус</th>
                            <th scope="col" class="col-2" style="vertical-align: middle; text-align: center;">Адрес</th>
                            <th scope="col" class="col-1" style="vertical-align: middle; text-align: center;">Способ оплаты</th>
                            <th scope="col" class="col-3" style="vertical-align: middle; text-align: center;">Товары</th>
                            <th scope="col" class="col-1" style="vertical-align: middle; text-align: center;">Количество</th>
                            <th scope="col" class="col-1" style="vertical-align: middle; text-align: center;">Стоимость</th>
                        </tr>
                        </thead>
                        <tbody>
                        <#list orders as order>
                            <tr>
                                <td class="col-2" style="vertical-align: middle; text-align: center;">${order.orderDate}</td>
                                <td class="col-2" style="vertical-align: middle; text-align: center;">${order.status}</td>
                                <td class="col-2" style="vertical-align: middle; text-align: center;">
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
                                <td class="col-1" style="vertical-align: middle; text-align: center;">${order.paymentMethod}</td>
                                <td class="col-3">
                                    <ul>
                                        <#list order.orderProducts as orderProduct>
                                        <a href="/product/${orderProduct.product.id}" class="product-link">
                                            <li>${orderProduct.product.title}</li>
                                        </a>
                                        </#list>
                                    </ul>
                                </td>
                                <td class="col-1">
                                    <ul>
                                        <#list order.orderProducts as orderProduct>
                                            <li>${orderProduct.quantity}</li>
                                        </#list>
                                    </ul>
                                </td>
                                <td class="col-1" style="vertical-align: middle; text-align: center;">
                                   <b>${order.totalPrice} РУБ.</b>
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
                    <hr>
                </div>
                <div class="row">
                    <div class="row">
                        <div class="col-md-8">
                        </div>
                        <div class="col-md-4">
                            <h3 style="text-align: right">Сумма выкупа: ${ransomAmount} РУБ.</h3>
                            <br><br>
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                            <div class="d-grid gap-2">
                                <button class="btn btn-outline-dark rounded-0" type="submit">
                                    Распечатать заказ
                                </button>
                            </div>
                            <br><br>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <br><br>
</@t.template>