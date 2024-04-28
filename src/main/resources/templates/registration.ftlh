<#import "blocks/template.ftlh" as t>
<@t.template user>

    <div class="row">
        <div class="col-md-3">
        </div>
        <div class="col-md-6">
            <h3 style="text-align: center">РЕГИСТРАЦИЯ</h3>
            <br>
                <form action="/registration" method="post">
                    <div class="form-group">
                        <label for="name">Имя пользователя</label>
                        <input type="text" class="form-control" required id="name" name="name">
                    </div>
                    <div class="form-group">
                        <label for="email">Электронная почта</label>
                        <input type="email" class="form-control" id="email" required name="email">
                    </div>
                    <div class="form-group">
                        <label for="phoneNumber">Номер телефона</label>
                        <input type="text" class="form-control" id="phoneNumber" required name="phoneNumber">
                    </div>
                    <div class="form-group">
                        <label for="password">Пароль</label>
                        <input type="password" class="form-control" id="password" required name="password">
                    </div>
                    <br>
                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                    <button type="submit" style="width: 100%" class="btn btn-outline-dark rounded-0">Регистрация</button>
                </form>
            <br>
        </div>
        <div class="col-md-3">
        </div>
    </div>

    <#if errorMessage??>
        <h2 style="color: red">${errorMessage}</h2>
    </#if>
</@t.template>