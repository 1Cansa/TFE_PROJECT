import {Controller} from "@hotwired/stimulus"
import L from 'leaflet'
import 'leaflet-routing-machine'
import 'leaflet.markercluster'

const tiles = {
    openstreetmap: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    mapbox: 'https://api.mapbox.com/styles/v1/mapbox/navigation-day-v1/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoiMWNhbnNhIiwiYSI6ImNsdzZ5cHp3bTFheWUydHJ6dHA4empteWEifQ.a3bODguIOY5HqhsVIvW48Q'
}

export default class CoordinateController extends Controller {

    initialize() {
        this.markers = new L.markerClusterGroup()
        this.map = L.map('map', {center: [-11.6, 27.4], zoom: 13});

        this.startMarker = L.marker([-11.57405909955857, 27.485894797487294]).addTo(this.map)
            .bindPopup('Swala Logistics')
            .openPopup();
        this.markers.addLayer(this.startMarker)

        L.tileLayer(tiles.mapbox, {
            maxZoom: 19,
            attribution: '&copy; <a href="https://mapbox.com">Mapbox</a>'
        }).addTo(this.map);
        super.initialize();
    }

    connect() {
        this.map.on('click', e => {
            this.markers.clearLayers()
            const input = document.querySelector('input#order_destination')

            input.removeAttribute('disabled')
            input.value = `${e.latlng.lat},${e.latlng.lng}`

            const destinationMarker = L.marker(e.latlng)
                .addTo(this.map)
                .bindPopup('Destination')
                .openPopup()

            this.markers.addLayers([this.startMarker, destinationMarker])
            this.map.addLayer(this.markers)

            this.map.fitBounds(new L.LatLngBounds([
                this.startMarker.getLatLng(),
                destinationMarker.getLatLng()
            ]))
        });
    }
}
