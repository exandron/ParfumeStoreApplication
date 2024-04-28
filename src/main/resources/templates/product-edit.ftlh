<#import "blocks/template.ftlh" as t>
<@t.template user>
    <style>
        .carousel-item img {
            width: 100%; /* Задайте желаемую ширину */
            height: 400px; /* Задайте желаемую высоту */
            object-fit: cover;
        }
    </style>
    <h1 style="text-align: center">Редактировать товар</h1>
    <hr>
    <div class="row">
        <div class="col-md-3">
            <div id="carouselExampleFade" class="carousel slide carousel-fade" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <#list images as image>
                        <div class="carousel-item<#if image?index == 0> active</#if> bg-white">
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
        <div class="col-md-2">
        </div>
        <div class="col-md-7">
            <form action="/product/edit/${product.id}" method="post">
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                <div class="form-group">
                    <label for="product">Название продукта:</label>
                    <input type="text" class="form-control" id="productName" name="productName" value="${product.title}" required>
                </div>
                <div class="form-group">
                    <label for="description">Описание:</label>
                    <input type="text" class="form-control" id="description" name="description" value="${product.description}" required>
                </div>
                <div class="form-group">
                    <label for="description">Цена:</label>
                    <input type="text" class="form-control" id="price" name="price" value="${product.price}" required>
                </div>
                <div class="form-group">
                    <label for="gender">Пол: </label>
                    <select id="gender" required name="gender" class="form-control">
                        <option value="">Пол не выбран</option>
                        <option value="Женские">Женские</option>
                        <option value="Мужские">Мужские</option>
                        <option value="Унисекс">Унисекс</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-light rounded-0">
                    Сохранить
                </button>
            </form>
        </div>
    </div>
    <hr>

</@t.template>