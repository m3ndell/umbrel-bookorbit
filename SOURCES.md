# Quellen und Recherche

Recherche am 4. November 2026.

## Big Bear

- Das ursprüngliche Repository `bigbeartechworld/big-bear-umbrel` lieferte bei der Recherche HTTP 404.
- Erhaltene Forks, unter anderem [lndr0x/big-bear-umbrel](https://github.com/lndr0x/big-bear-umbrel), [sigmadev21/big-bear-umbrel-Sigma](https://github.com/sigmadev21/big-bear-umbrel-Sigma), [ianooneUknow/big-bear-umbrel](https://github.com/ianooneUknow/big-bear-umbrel) und [sodove/big-bear-umbrel](https://github.com/sodove/big-bear-umbrel), lieferten die Store-Struktur, aber keinen BookOrbit- oder BookLore-Eintrag im untersuchten Standardbranch.
- Das Web Archive meldete auch bei Abfrage für Anfang November als verfügbaren nächsten Snapshot [3. März 2026, 11:30:31 UTC](https://web.archive.org/web/20260303113031/https://github.com/bigbeartechworld/big-bear-umbrel). Die abgerufene Repository-Seite enthält BookStack, aber keinen BookOrbit-Eintrag.
- Für den vermuteten Raw-Pfad `master/big-bear-umbrel-bookorbit/docker-compose.yml` wurde kein Snapshot gefunden. Das beweist nicht, dass es nie eine entsprechende App oder einen anders benannten Pfad gab. Eine exakte Wiederherstellung der alten BookOrbit-Konfiguration wird nicht behauptet.

## Paketgrundlage

- [Offizielles Umbrel Community App Store Template](https://github.com/getumbrel/umbrel-community-app-store): Store-ID, App-Präfix und Dateistruktur.
- [BookOrbit 3.6.0](https://github.com/bookorbit/bookorbit/releases/tag/v3.6.0): verifiziertes aktuelles Release zum Recherchezeitpunkt.
- [Upstream Compose](https://github.com/bookorbit/bookorbit/blob/v3.6.0/docker-compose.yml), [Umgebungsvariablen](https://github.com/bookorbit/bookorbit/blob/v3.6.0/.env.example), [Entrypoint](https://github.com/bookorbit/bookorbit/blob/v3.6.0/server/entrypoint.sh): PostgreSQL, Persistenz, Dateirechte und Sicherheitsoptionen.
- [Vorhandenes BookOrbit-Paket im NYTT-Store](https://github.com/8johnr8/not-your-typical-tech-umbrel/tree/main/nytt-bookorbit): Abgleich der Umbrel-spezifischen Integration, Setup-Token über `APP_PASSWORD`, Schlüsselableitung, Ordner- und Umgebungseinstellungen. Dieses Paket ist kein Big-Bear-Fork.
- [Offizielles Nextcloud-Paket](https://github.com/getumbrel/umbrel-apps/tree/master/nextcloud): Abgleich von `deterministicPassword` und `APP_PASSWORD`.

Die App- und Datenbank-Digests sowie deren AMD64-/ARM64-Manifeste wurden direkt an den Container-Registries geprüft. Bilder im App-Listing werden aus dem BookOrbit-Release-Tag referenziert. BookOrbit selbst und dessen Grafiken unterliegen den jeweiligen [Upstream-Lizenzbedingungen](https://github.com/bookorbit/bookorbit/blob/v3.6.0/LICENSE) einschließlich der dortigen zusätzlichen Hinweise; sie werden durch die Lizenz dieses Stores nicht neu lizenziert.
