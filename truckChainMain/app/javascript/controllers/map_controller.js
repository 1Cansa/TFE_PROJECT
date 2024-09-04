import {Controller} from "@hotwired/stimulus"
import L from 'leaflet'
import 'leaflet-routing-machine'
import 'leaflet.markercluster'
import consumer from "../channels/consumer";

const tiles = {
    openstreetmap: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    mapbox: 'https://api.mapbox.com/styles/v1/mapbox/navigation-day-v1/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoiMWNhbnNhIiwiYSI6ImNsdzZ5cHp3bTFheWUydHJ6dHA4empteWEifQ.a3bODguIOY5HqhsVIvW48Q'
}

export default class MapController extends Controller {
    static values = {start: String, destination: String }

    initialize() {
        this.truckMarker = undefined
        this.truckIcon = new L.icon({
            iconUrl: '/images/truck.png',
            iconSize: [60, 60],
        });
        this.markers = new L.markerClusterGroup()
        this.map = L.map('map', {center: [-11.6, 27.4], zoom: 13})

        L.tileLayer(tiles.mapbox, {
            maxZoom: 19,
            attribution: '&copy; <a href="https://mapbox.com">Mapbox</a>'
        }).addTo(this.map);
        super.initialize();
    }

    connect() {
        if (this.element.hasAttribute('data-order-id')) {
            const orderId = this.element.getAttribute('data-order-id');
            consumer.subscriptions.create({ channel: "LogChannel", order_id: orderId }, {
                received: (data) => {
                    data = JSON.parse(data);

                    if(this.truckMarker !== undefined) {
                        this.map.removeLayer(this.truckMarker)
                    }

                    this.truckMarker = L.marker([data.lat, data.lng], {icon: this.truckIcon})
                    this.map.addLayer(this.truckMarker)
                }
            });
        }

        const start = this.startValue.split(',').map(c => parseFloat(c))
        const destination = this.destinationValue.split(',').map(c => parseFloat(c))

        this.truckMarker = L.marker([-11.580460, 27.490503], {icon: this.truckIcon})
        this.map.addLayer(this.truckMarker)

        this.markers.addLayers([
            L.marker(start).bindPopup('Swala').openPopup(),
            L.marker(destination).bindPopup('Destination').openPopup(),
        ])

        this.map.addLayer(this.markers)
        this.map.fitBounds(new L.LatLngBounds([start, destination]))
    }
}
