<#import "blocks/template.ftlh" as t>
<@t.template user>
    <div class="card-body">
        <blockquote class="blockquote mb-0">
            <div class="row">
                <div class="col-md-3">
                </div>
                <div class="col-md-6">
                    <h1 style="text-align: center">Личный кабинет</h1>
                    <hr>
                    <br>
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
                        <br>
                        <br>
                        <#if user.isAdmin()>
                            <a class="btn btn-dark mb-3" style="text-align: center; width: 100%"
                               href="/admin">
                                Панель администратора
                            </a>
                            <a class="btn btn-dark mb-3" style="text-align: center; width: 100%"
                               href="/my/products">
                                Добавить товар
                            </a>
                            <a class="btn btn-dark mb-3" style="text-align: center; width: 100%"
                               href="/order/statistics">
                                Статистика по продажам
                            </a>
                            <a class="btn btn-dark mb-3" style="text-align: center; width: 100%"
                               href="/admin/statistics">
                                Статистика по пользователям
                            </a>
                        </#if>
                        <form action="/cart" method="get">
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                            <button type="submit" style="text-align: center; width: 100%" class="btn btn-dark mb-3">
                                Корзина
                            </button>
                        </form>
                        <form action="/order/my-orders" method="get">
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                            <button type="submit" style="text-align: center; width: 100%" class="btn btn-dark mb-3">
                                Мои заказы
                            </button>
                        </form>
                        <form action="/logout" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                            <button type="submit" style="text-align: center; width: 100%" class="btn btn-danger mb-2">
                                Выйти из аккаунта
                            </button>
                        </form>
                    </div>
                </div>
                    <div class="col-md-3">
                    </div>
            </div>
        </blockquote>
    </div>
    <br><br>
</@t.template>