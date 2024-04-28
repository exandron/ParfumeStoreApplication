<#import "blocks/template.ftlh" as t>
<@t.template user>
    <style>
        .carousel-item img {
            width: 100%; /* Задайте желаемую ширину */
            height: 600px; /* Задайте желаемую высоту */
            object-fit: cover;
        }
    </style>
    <div class="row">
        <div class="col-md-4">
            <div id="carouselExampleFade" class="carousel slide carousel-fade" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <#list images as image>
                        <div class="carousel-item <#if image?index == 0> active</#if> bg-white">
                            <img src="/images/${image.id}" class="d-block w-100" alt="...">
                        </div>
                    </#list>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Предыдущий</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Следующий</span>
                </button>
            </div>
        </div>
        <div class="col-md-1">
        </div>
        <div class="col-md-7">
            <#if user.isAdmin()>
                <div class="text-end">
                    <form action="/product/edit/${product.id}" method="get" class="d-inline">
                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                        <button class="btn btn-primary btn-dark rounded-0" type="submit">
                            Изменить
                        </button>
                    </form>
                    <form action="/product/delete/${product.id}" method="post" class="d-inline">
                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                        <button type="submit" class="btn btn-primary btn-dark rounded-0">
                            Удалить
                        </button>
                    </form>
                </div>
            <#else>
            </#if>
            <p><h1 style="text-align: center">${product.title} </h1></p>
            <hr>
            <p><b>Описание: </b>${product.description}</p>
            <p><b>Пол: </b>${product.gender}</p>
            <hr>

            <form action="/cart/${product.id}" method="post" class="d-inline">
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                <div class="d-grid gap-2">
                    <div class="row">
                        <div class="col-md-12">
                            Количество: <input type="number" class="btn btn-outline-dark rounded-0" name="quantity" min="1" max="100" value="1" step="1">
                        </div>
                    </div>
                    <div>
                        <div>
                            <p><h2 style="text-align: center">${product.price} РУБ</h2></p>
                        </div>
                    </div>
                    <button class="btn btn-outline-dark rounded-0" type="submit">
                        Добавить в корзину
                    </button>
                </div>
            </form>
            <br><br>
        </div>
    </div>
</@t.template>