import {Controller} from "@hotwired/stimulus";
import consumer from "../channels/consumer";

export default class LiveController extends Controller
{
    connect() {
        consumer.subscriptions.create({ channel: "LogChannel", order_id: this.element.id }, {
            received(data) {
                data = JSON.parse(data);
                document.querySelector("#live_temperature").innerHTML = data.temperature;
                document.querySelector("#live_positon").innerHTML = `${data.lat}, ${data.lng}`;
                document.querySelector("#live_quantity").innerHTML = data.quantity
            }
        });
    }
}
