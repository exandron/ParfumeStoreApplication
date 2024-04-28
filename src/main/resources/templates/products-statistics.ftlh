<#import "blocks/template.ftlh" as t>
<@t.template user>
    <div class="card">
        <h2 style="text-align: center">Самые покупаемые товары</h2>
        <hr>
        <!-- Подключение библиотеки Chart.js -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <div class="row">
            <div class="col-md-2">
            </div>
            <div class="col-md-8">
                <canvas id="orderChart"></canvas>
            </div>
            <div class="col-md-2">
            </div>
        </div>

        <!-- JavaScript код для создания графика -->
        <script>
            var ctx = document.getElementById('orderChart').getContext('2d');

            var productsJson = "${productsJson?js_string}";

            var products = JSON.parse(productsJson.replace(/&quot;/g, '"'));
            var orderQuantities = {};

            products.forEach(function(product) {
                var totalQuantity = 0;
                product.orderProducts.forEach(function(orderProduct) {
                    totalQuantity += orderProduct.quantity;
                });

                // Проверка, был ли товар уже добавлен
                if (!orderQuantities.hasOwnProperty(product.title)) {
                    orderQuantities[product.title] = totalQuantity;
                } else {
                    orderQuantities[product.title] += totalQuantity; // Обновляем сумму quantity для дублирующегося товара
                }
            });

            var sortedData = Object.entries(orderQuantities).sort(function(a, b) {
                return b[1] - a[1];
            });

            var top5Data = sortedData.slice(0, 5);

            var top5Labels = [];
            var top5Values = [];
            for (var i = 0; i < top5Data.length; i++) {
                top5Labels.push(top5Data[i][0]);
                top5Values.push(top5Data[i][1]);
            }

            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: top5Labels,
                    datasets: [{
                        label: 'Количество покупок',
                        data: top5Values,
                        backgroundColor: 'rgba(0, 123, 255, 0.5)'
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Количество покупок'
                            },
                            ticks: {
                                stepSize: 1,
                                callback: function(value) {
                                    if (value % 1 === 0) {
                                        return value;
                                    }
                                    return '';
                                }
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'Продукты'
                            }
                        }
                    }
                }
            });
        </script>
    </div>
</@t.template>