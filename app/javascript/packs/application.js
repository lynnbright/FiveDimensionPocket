require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("styles")

import $ from 'jquery'
window.$ = $

import 'bootstrap/dist/js/bootstrap.js'
import 'bootstrap/dist/css/bootstrap.min.css'

import "@fortawesome/fontawesome-free/js/all"

import 'select2'
import 'select2/dist/css/select2.css'

import 'sweetalert2'
import Swal from 'sweetalert2'
window.Swal = Swal

import 'chart.js'
import 'chart.js/dist/Chart.css'
import Chart from 'chart.js'
window.Chart = Chart

import "controllers"
