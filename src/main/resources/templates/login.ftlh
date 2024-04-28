<#import "blocks/template.ftlh" as t>
<@t.template user>
    <div class="row">
        <div class="col-md-3">
        </div>
        <div class="col-md-6">
            <h3 style="text-align: center">АВТОРИЗАЦИЯ</h3>
            <br>
            <form action="/login" method="post">
                <div class="form-group">
                    <label for="email">Электронная почта</label>
                    <input type="email" class="form-control <#if RequestParameters?? && RequestParameters.error??>is-invalid</#if>" id="email" name="username">
                    <div id="email-error" class="invalid-feedback">
                            Неверная электронная почта
                    </div>
                </div>
                <div class="form-group">
                    <label for="password">Пароль</label>
                    <input type="password" class="form-control <#if RequestParameters?? && RequestParameters.error??>is-invalid</#if>" id="password" name="password">
                    <div id="password-error" class="invalid-feedback">
                            Неверный пароль
                    </div>
                </div>
                <br>
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <button type="submit" style="width: 100%" class="btn btn-outline-dark rounded-0">Войти</button>
            </form>
        </div>
        <div class="col-md-3">
        </div>
    </div>
    <hr>
    <h3>Нет аккаунта? <a href="/registration">Зарегистрируйтесь!</a></h3>
</@t.template>