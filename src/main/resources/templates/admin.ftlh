<#import "blocks/template.ftlh" as t>
<@t.template user>
    <h1 style="text-align: center">Панель администратора</h1><hr>
    <table class="table table-hover table-secondary">
        <tr>
            <th scope="col" style="vertical-align: middle; text-align: center;">Email</th>
            <th scope="col" style="vertical-align: middle; text-align: center;">Номер телефона</th>
            <th scope="col" style="vertical-align: middle; text-align: center;">Активность</th>
            <th scope="col" style="vertical-align: middle; text-align: center;">Роли</th>
            <th scope="col" style="vertical-align: middle; text-align: center;">Бан</th>
            <th scope="col" style="vertical-align: middle; text-align: center;">Редактирование</th>
            <th scope="col" style="vertical-align: middle; text-align: center;">Подробная информация</th>
            <th scope="col" style="vertical-align: middle; text-align: center;"></th>
        </tr>
        <#list users as user>
            <tr>
                <th style="vertical-align: middle; text-align: center;">${user.email}</th>
                <th style="vertical-align: middle; text-align: center;">${user.phoneNumber}</th>
                <th style="vertical-align: middle; text-align: center;"><#if user.active>true<#else>false</#if></th>
                <th style="vertical-align: middle; text-align: center;"><#list user.roles as role>${role}</#list></th>
                <th style="vertical-align: middle; text-align: center;">
                    <form action="/admin/user/ban/${user.id}" method="post">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <input type="submit" class="btn btn-outline-dark rounded-0" value="Бан">
                    </form>
                </th>
                <th style="vertical-align: middle; text-align: center;"><a href="/admin/user/edit/${user.id}">Редактировние</a></th>
                <th style="vertical-align: middle; text-align: center;"><a href="/user/${user.id}">Подробная информация</a></th>
                <th style="vertical-align: middle; text-align: center;">
                    <form action="/admin/user/delete/${user.id}" method="post" class="d-inline">
                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                        <button type="submit" class="btn btn-outline-dark rounded-0">
                            Удалить
                        </button>
                    </form>
                </th>
            </tr>
        <#else>
            <h3>Пользователей нет</h3>
        </#list>
    </table>
</@t.template>