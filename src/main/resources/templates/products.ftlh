<#import "blocks/template.ftlh" as t>
<@t.template user>
    <style>
        .card-img-contain {
            object-fit: contain;
            background-color: white;
        }
    </style>

    <div id="carouselExampleFade" class="carousel slide carousel-fade">
        <div class="carousel-inner">
            <div class="carousel-item active bg-body">
                <img src="/static/images/main2.jpg" class="d-block w-100">
            </div>
            <div class="carousel-item bg-body">
                <img src="/static/images/main1.jpg" class="d-block w-100">
            </div>
            <div class="carousel-item bg-body">
                <img src="/static/images/main3.png" class="d-block w-100">
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden"></span>
        </button>
    </div>

    <hr>

    <div>
        <form method="get" action="/">
            <div class="form-row align-items-center">
                <div class="col">
                    <label class="sr-only" for="searchTitle">Поиск по названию</label>
                    <input type="text" name="title" <#if title??>value="${title}"</#if> class="form-control" id="searchTitle" placeholder="Поиск по названию">
                </div>
                <div class="col-auto">
                    <button type="submit" class="btn btn-dark rounded-0">Поиск</button>
                </div>
            </div>
        </form>
    </div>

    <hr>

    <div class="row" >
        <div class="col-md-3">
            <form method="get" action="/">
                <div class="form-group col-md-12">
                    <label for="searchGender">Пол</label>
                    <select id="searchGender" name="gender" class="form-control">
                        <option value="">Пол не выбран</option>
                        <option value="Женские">Женские</option>
                        <option value="Мужские">Мужские</option>
                        <option value="Унисекс">Унисекс</option>
                    </select>
                </div>
                <button style="width: 100%" type="submit" class="btn btn-dark rounded-0">Найти</button>
            </form>
        </div>
        <div class="col-md-9">
            <div class="card-columns">
                <#list products as product>
                    <a href="/product/${product.id}" class="product-link">
                        <div class="card text-white bg-dark my-3 product" style="width: 300px; height: 450px;">
                            <img src="/images/${product.previewImageId}" class="card-img-top card-img-contain" width="300" height="300">
                            <div class="card-body">
                                <h5 class="card-title">${product.title}</h5>
                                <p class="card-text">${product.price} РУБ</p>
                            </div>
                            <div class="card-footer">
                                ${product.gender}
                            </div>
                        </div>
                    </a>
                <#else>
                    <h1 style="text-align: center">Не найдено</h1>
                </#list>
            </div>
        </div>
    </div>
</@t.template>