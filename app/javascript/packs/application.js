require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("scripts")
require("articles_sharebtn")

import $ from 'jquery'
window.$ = window.jquery = $

import 'bootstrap/dist/js/bootstrap.js'
import 'bootstrap/dist/css/bootstrap.min.css'
require("styles")


import "@fortawesome/fontawesome-free/js/all"

import 'select2'
import 'select2/dist/css/select2.css'

import 'sweetalert2'

import 'chart.js'
import 'chart.js/dist/Chart.css'


import "controllers"