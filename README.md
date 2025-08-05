# hurcules_1.0
CyberMap Explorer is a powerful web application that visually displays a broad range of cyber domain devices and critical infrastructure across the United States on an interactive map. Integrating data from top open source intelligence and mapping services, it offers real-time situational awareness for researchers and cybersecurity professionals.

# CyberMap Explorer

## Overview

CyberMap Explorer is a comprehensive web application designed to visually display a wide spectrum of cyber domain devices and critical infrastructure across the United States on an interactive map. Harnessing data from leading open-source intelligence and mapping sources, the platform enables real-time situational awareness for researchers, analysts, and security professionals alike.

## Key Features

### Interactive Mapping
Seamlessly visualize cyber assets (servers, IoT, ICS/SCADA, etc.) and critical infrastructure such as energy grids, water systems, and transportation hubs overlaid on a detailed map interface.

### Data Aggregation
Integrates and displays real-time and historical data from multiple sources:

- **Google Maps, Wikimapia**: Base maps and infrastructure data
- **Shodan, Censys**: Networked devices, services, and detected vulnerabilities
- **Hunter.io**: Email address exposure and domain relationships
- **Wi-Fi War Driving**: Visualization of discovered public and private wireless networks
- **Additional APIs**: Easily extensible to other public or free data sources

### Custom Filtering
Users can filter by device type, vulnerability status, infrastructure category, Wi-Fi strength, and more.

### Geospatial Analytics
Interactive heatmaps and clustering to identify hotspots, anomalies, and dense regions of cyber-relevant activity.

### Critical Infrastructure Overlays
Cross-reference cyber assets with open-source records of essential facilities and public safety points.

### Open Source & Extensible
Built with modularity in mind—developers can add new APIs and custom visualizations.

## Use Cases

- Security researchers mapping exposure of critical infrastructure
- Cyber threat intelligence analysts tracking vulnerable devices
- Journalists and academics studying correlations between digital and physical infrastructure
- Hobbyists interested in Wi-Fi war driving, open internet mapping, and infosec exploration

## Tech Stack

- **Frontend**: React (Leaflet.js or Mapbox GL for mapping)
- **Backend**: Node.js/Python for API integration and aggregation
- **Data Sources**: Google Maps, Wikimapia, Shodan, Censys, Hunter.io, public federal infrastructure databases, and more
- **Deployment**: Docker, AWS/Azure/GCP ready

## Getting Started

1. Fork and clone the repository
2. Set up API keys for the supported services
3. Run locally with `docker-compose up` or follow deployment instructions
4. Access `http://localhost:3000` to begin exploring

## Ethics & Legal Note

This project aggregates only lawful, publicly accessible data and is intended exclusively for research, education, and defense of networks. Use responsibly.

## Contributing

Pull requests are welcome! Please see the [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines and to suggest new integrations or features.

## License

Open source under the MIT License.
