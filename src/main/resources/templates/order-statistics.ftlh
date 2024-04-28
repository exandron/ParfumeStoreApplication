<#import "blocks/template.ftlh" as t>
<@t.template user>
    <div class="card">
        <h2 style="text-align: center">Статистика стоимости заказов по времени оформления</h2>
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
            // Создание контекста для рисования графика
            var ctx = document.getElementById('orderChart').getContext('2d');

            var ordersJson = "${ordersJson?js_string}";
            var orders = JSON.parse(ordersJson.replace(/&quot;/g, '"'));
            var orderData = {
                labels: [],
                datasets: [{
                    label: 'Итоговая стоимость заказа (РУБ.)',
                    data: [],
                    backgroundColor: 'rgba(0, 123, 255, 0.5)',
                    borderColor: 'rgba(0, 123, 255, 1)',
                    borderWidth: 1
                }]
            };

            // Заполнение данных для графика
            orders.forEach(function(order) {
                var orderDate = new Date(...order.orderDate.slice(0, 6));
                var totalPrice = order.totalPrice;

                // Форматирование даты в строку (замените на подходящий формат)
                var formattedDate = orderDate.toLocaleDateString();

                orderData.labels.push(formattedDate);
                orderData.datasets[0].data.push(totalPrice);
            });

            // Создание графика с использованием библиотеки Chart.js
            var chart = new Chart(ctx, {
                type: 'line',
                data: orderData,
                options: {
                    responsive: true,
                    scales: {
                        x: {
                            display: true,
                            scaleLabel: {
                                display: true,
                                labelString: 'Дата оформления заказа'
                            }
                        },
                        y: {
                            display: true,
                            scaleLabel: {
                                display: true,
                                labelString: 'Итоговая стоимость (РУБ.)'
                            },
                            beginAtZero: true
                        }
                    }
                }
            });
        </script>
    </div>
</@t.template>