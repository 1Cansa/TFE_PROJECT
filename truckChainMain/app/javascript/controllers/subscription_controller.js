import {Controller} from "@hotwired/stimulus";

export default class SubscriptionController extends Controller {
    connect() {
        const ws = new WebSocket('ws://localhost:8080');

        ws.onopen = () => {
            const logDiv = document.getElementById('log');
            logDiv.innerHTML += '<p>WebSocket connecté</p>';
            console.log('WebSocket connecté');
        };

        ws.onmessage = (event) => {
            const data = JSON.parse(event.data);
            document.getElementById('data').innerText = JSON.stringify(data, null, 2);
        };

        ws.onerror = (error) => {
            const logDiv = document.getElementById('log');
            logDiv.innerHTML += '<p>Erreur de WebSocket: ' + error.message + '</p>';
            console.error('Erreur de WebSocket:', error);
        };
    }
}
