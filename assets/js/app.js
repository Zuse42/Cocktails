// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"
import {Socket} from "phoenix"
import NProgress from "nprogress"
import {LiveSocket} from "phoenix_live_view"


import 'bootstrap' //Bootstrap support!
import jQuery from "jquery"
import 'bootstrap-select'

let Hooks = {}

Hooks.PhoneNumber = {
    mounted() {
        this.el.addEventListener("input", e => {
            let match = this.el.value.replace(/\D/g, "").match(/^(\d{3})(\d{3})(\d{4})$/)
            if(match) {
                this.el.value = `${match[1]}-${match[2]}-${match[3]}`
            }
        })
    }
}

Hooks.SelectSomething = {

    initSelectPicker() {
        console.log("hello");

        let hook = this,
            $select = jQuery(hook.el).find("select");
        jQuery('select').selectpicker()

        $select.on("change", (e) => hook.selected(hook, e))

        return $select;
    },

    mounted() {
        this.initSelectPicker();
    },

    selected(hook, event) {
        var selectedItem = jQuery('.selectpicker').val();
        console.log();

        hook.pushEvent("Cockteil_selected", {this: selectedItem})
    }
}





let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, { hooks: Hooks, params: {_csrf_token: csrfToken}})

// Show progress bar on live navigation and form submits
window.addEventListener("phx:page-loading-start", info => NProgress.start())
window.addEventListener("phx:page-loading-stop", info => NProgress.done())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket













