# BookOrbit für Umbrel

Ein unabhängiger Community App Store von **m3ndell**, der ausschließlich **BookOrbit 3.8.0** enthält. Kein offizieller Store von Umbrel, Big Bear oder BookOrbit.

Dieses Paket enthält **BookOrbit 3.8.0** mit getrennten Mounts für Bücher und Hörbücher.

## Installation

1. In Umbrel den **App Store** öffnen und im Menü **Community App Stores** wählen (die Bezeichnung hängt von der umbrelOS-Version ab).
2. Diese Repository-Adresse hinzufügen:

   ```text
   https://github.com/m3ndell/umbrel-bookorbit
   ```

3. Im Store **Mendell BookOrbit** die App **BookOrbit** installieren.
4. BookOrbit öffnen. Das von Umbrel angezeigte App-Passwort im Feld **Setup Token** eingeben und einen eigenen Administrator mit eigenem Passwort anlegen.
5. Bücher hochladen oder unter den Umbrel-App-Einstellungen einen vorhandenen Bücherordner auswählen; in BookOrbit **`/books`** als Bibliothek hinzufügen. Für Hörbücher gibt es eine eigene Ordnerauswahl **Hörbücher** mit dem Containerpfad **`/audiobooks`**. Die Ordnerauswahl und Umgebungsvariablen im UI benötigen eine umbrelOS-Version, die diese Funktionen unterstützt. Der Standardordner funktioniert unabhängig davon.

Standardadresse: `http://umbrel.local:8909` beziehungsweise die in Umbrel konfigurierte Geräteadresse mit Port `8909`.

## Speicherung und Konfiguration

Die App-ID ist `mendell-bookorbit`, der Store-Präfix `mendell`. Unter `<Umbrel-App-Datenverzeichnis>/mendell-bookorbit/data/` liegen:

| Ordner | Inhalt |
| --- | --- |
| `app/` | BookOrbit-Anwendungsdaten, Cover und interne Dateien |
| `books/` | Standard-Bibliothek, im Container `/books` |
| `audiobooks/` | Standard-Hörbücherordner, im Container `/audiobooks` |
| `postgres/` | PostgreSQL-Datenbank einschließlich pgvector |

Über **Einstellungen → Ordner** kannst du Bücher und Hörbücher getrennt auf vorhandene NAS-Ordner legen. Der gewählte Ordner ersetzt jeweils den Standard-Mount unter `/books` beziehungsweise `/audiobooks`. Beide Ordner müssen für UID/GID `1000:1000` beschreibbar sein; das Paket ändert die Besitzrechte ausgewählter externer Ordner nicht automatisch. BookOrbit kann Dateien in diesen Ordnern bearbeiten, wenn entsprechende Funktionen benutzt werden.

Für Hörbücher in BookOrbit eine Bibliothek für `/audiobooks` hinzufügen. Der Ordnerdialog beginnt jetzt bei `/`, damit beide Mounts auswählbar sind. Bücher und Hörbücher werden weiterhin dauerhaft in ihren getrennten Ordnern gespeichert.

Unter **Einstellungen → Umgebung** können `APP_URL` und `TZ` gesetzt werden, etwa `https://books.example.com` und `Europe/Berlin`. Für Kobo, E-Mail-Links und OIDC muss `APP_URL` die tatsächlich erreichbare Adresse sein. Ein Eintrag dort richtet keinen Tunnel ein. Auf älteren Umbrel-Versionen sind diese Werte in der Compose-Konfiguration anzupassen; lokale Änderungen können bei Store-Updates überschrieben werden.

BookOrbit nutzt eigene Benutzerkonten. Der zusätzliche Umbrel-Proxy-Login ist deaktiviert, damit OPDS, Kobo und KOReader funktionieren. Datenbank und App veröffentlichen keine zusätzlichen direkten Host-Ports; Umbrel stellt den App-Proxy bereit.

Secrets werden von Umbrel bereitgestellt beziehungsweise getrennt über `derive_entropy` abgeleitet. Sie bleiben bei normalen App-Updates stabil. Für eine vollständige Wiederherstellung müssen neben den Daten auch die bisherigen Secrets erhalten bleiben.

## Vorhandene Big-Bear-Installation

Diese App hat eine eigene ID und installiert sich als separate Instanz. Es gibt **keine automatische Übernahme** einer bisherigen Installation. Die ursprüngliche BookOrbit-Konfiguration konnte in den verfügbaren Forks und Archivfunden nicht verifiziert werden.

Die alte App vorerst behalten und vor einem Umzug Bücher, App-Daten, Datenbank und die bisherigen Secrets sichern. Für ein konsistentes Datenbank-Backup PostgreSQL-Werkzeuge verwenden oder die alte Instanz während einer vollständigen Dateisicherung stoppen. Eine laufende PostgreSQL-Datenablage nicht einfach kopieren. Datenverzeichnis-Kopien sind außerdem an die PostgreSQL-Hauptversion gebunden; bei unterschiedlichen Versionen ist ein logischer Export/Import nötig.

Das alte `JWT_SECRET` und vorhandene Verschlüsselungsschlüssel müssen bei einem vollständigen Umzug erhalten bleiben. Bei älteren BookOrbit-Versionen ohne eigenen Podcast-Schlüssel verlangt Upstream zunächst das bisherige `JWT_SECRET` als `PODCAST_ENCRYPTION_KEY`. Bibliothekspfade sind ebenfalls abzugleichen. Ohne die alte Konfiguration kann dieses Repository keinen sicheren automatischen Umzug anbieten. Die neue Instanz erst nach erfolgreicher Prüfung als Ersatz verwenden und die alte App erst nach gesichertem Backup entfernen.

## Update von 3.6 auf 3.7

**BookOrbit 3.7.0 entfernt die Podcast-Funktion.** Beim ersten Start führt der
Upstream-Entrypoint automatisch die Migration
[`0132_drop_podcasts.sql`](https://github.com/bookorbit/bookorbit/blob/v3.7.0/server/src/db/migrations/0132_drop_podcasts.sql)
aus. Sie löscht die Podcast-Tabellen einschließlich Feed-Abonnements,
Episodeninformationen, Lesezeichen, Warteschlangen und Hörverlauf. Auch
Podcast-bezogene Spalten der Bibliotheks-, Sammlungs- und Smart-Scope-Tabellen
werden entfernt. Das Store-Update führt selbst keine Migration auf deinem NAS
aus; dies geschieht erst, wenn dort der neue BookOrbit-Container startet.

Vor der Installation ein vollständiges, konsistentes Backup von Datenbank und
App-Daten einschließlich Secrets anlegen. Ein späterer Wechsel zurück zum
3.6-Image allein stellt gelöschte Daten nicht wieder her. Wer Podcast-Daten
behalten muss, sollte bei 3.6 bleiben, bis sie gesichert oder exportiert sind.

Bücher und Hörbücher behalten ihre bisherigen Mounts `/books` und
`/audiobooks`. PostgreSQL-Version und vorhandene Schlüssel bleiben unverändert.
Die bestehenden Podcast-Schlüssel werden nicht gelöscht, auch wenn 3.7 sie
nicht mehr verwendet.

## Version und Umfang

- BookOrbit **3.8.0**, auf den geprüften Multiarch-Image-Digest festgelegt.
- PostgreSQL **18 mit pgvector**, ebenfalls auf einen Multiarch-Digest festgelegt.
- `linux/amd64` und `linux/arm64` werden von beiden Images angeboten; kein ARMv7-Paket.
- Web-Reader, Bibliothek, OPDS und Geräteanbindungen gehören zum Hauptcontainer.
- Die optionalen separaten Kokoro-TTS- und Read-Aloud-Worker sind nicht enthalten. Read-Aloud-Erzeugung benötigt einen zusätzlich eingerichteten Worker.
- Künftige Releases werden nicht automatisch über einen `latest`-Tag eingespielt. Für Updates müssen Manifest und Image-Digest gemeinsam geändert werden.

Quellen und Recherchegrenzen stehen in [SOURCES.md](SOURCES.md). Die Konfiguration wurde statisch geprüft; ein Installations- und Funktionstest auf echter Umbrel-Hardware steht aus.
