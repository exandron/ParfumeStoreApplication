<#import "blocks/template.ftlh" as t>
<@t.template user>
    <div class="card">
        <h2 style="text-align: center">Диаграмма количества пользователей</h2>
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

            var usersJson = "${usersJson?js_string}";
            var users = JSON.parse(usersJson.replace(/&quot;/g, '"'));

            // Создание данных для графика
            var userData = {
                labels: ['Пользователь', 'Администратор'],
                datasets: [{
                    label: 'Количество пользователей',
                    data: [0, 0], // Изначально установлено значение 0 для каждой категории
                    backgroundColor: ['rgba(255, 99, 132, 0.5)', 'rgba(54, 162, 235, 0.5)'],
                    borderColor: ['rgba(255,99,132,1)', 'rgba(54, 162, 235, 1)'],
                    borderWidth: 1
                }]
            };

            // Подсчет количества пользователей по категориям
            users.forEach(function(user) {
                if (user.admin) {
                    userData.datasets[0].data[1]++; // Увеличение счетчика для admin
                } else {
                    userData.datasets[0].data[0]++; // Увеличение счетчика для user
                }
            });

            // Создание графика с использованием библиотеки Chart.js
            var chart = new Chart(ctx, {
                type: 'bar', // Изменено на тип 'bar' для создания столбчатой диаграммы
                data: userData,
                options: {
                    responsive: true,
                    scales: {
                        x: {
                            display: true,
                            scaleLabel: {
                                display: true,
                                labelString: 'Тип пользователя'
                            }
                        },
                        y: {
                            display: true,
                            scaleLabel: {
                                display: true,
                                labelString: 'Количество пользователей'
                            },
                            beginAtZero: true,
                            ticks: {
                                stepSize: 1, // Установка шага равным 1
                                callback: function(value) {
                                    if (value % 1 === 0) { // Проверка, является ли значение целым числом
                                        return value;
                                    }
                                    return ''; // Вернуть пустую строку для значения с десятичной частью
                                }
                            }
                        }
                    }
                }
            });
        </script>
    </div>
</@t.template>