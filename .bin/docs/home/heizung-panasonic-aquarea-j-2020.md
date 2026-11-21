# Panasonic Aquarea (Generation J, Innen- und Außengerät, 3 kW Heizstab)

**Gebäude:** Baujahr 2020, Fußbodenheizung (+ große Heizkörper im gedämmten Keller), keine Taupunktsensoren

---

## Aktuelle System- & Installateur-Einstellungen
- **Pumpenfließrate:** `ΔT` (dynamische Regelung nach Temperaturspreizung)
- **Max. Pumpendrehzahl (Service):** `0x65` (Werkseinstellung, Testbetrieb: `AUS`)
- **Kapazität Warmwasser:** `Variable`
- **Flüssigkeit:** `Wasser`
- **Frostschutz:** `Ja`
- **Gehäuseheizung:** `Nein`
- **Altern. Außenfühler:** `Ja`
- **Bivalente Heizung:** `Nein`
- **Ext. Ein/Aus-Schalter:** `Nein`
- **Heizkreise u. Fühler:** `Wassertemperatur`
- **Optionale Platine:** `Nein`
- **Leistung E-Heizstab:** `3 kW`
- **Man. E-Heizung:** `Man.`
- **Man. Abtauen:** `Auto` (Abtausignal: `Nein`)

---

## Betriebseinstellungen (inkl. Optimierungen)

### Heizen
- **Regelungsart:** `Heizkurve`
- **Heizkurve (optimiert):**
  - Bei `-10 °C` Außentemperatur → **`35 °C`** Vorlauf *(vorher -5 °C)*
  - Bei `+15 °C` Außentemperatur → **`25 °C`** Vorlauf
- **Sommerabschaltung (`Heiz. AUS: Außentemp.`):** **`16 °C`** *(vorher 18 °C)*
- **Spreizung (`Heizbetr.: ΔT`):** **`4 °C`** *(vorher 5 °C)*
- **Heizstab-Freigabe (`Heiz. EIN: Außentemp.`):** **`-12 °C`**

### Kühlen & Auto-Modus
- **Kühlbetr. Wassertemp:** `Festwert` bei **`18 °C`** (Taupunktschutz ohne Sensoren; Keller-Heizkörper im Sommer zudrehen)
- **Auto Umschaltpunkt Heizen → Kühlen:** **`25 °C`**
- **Auto Umschaltpunkt Kühlen → Heizen:** **`15 °C`**

### Warmwasser (WW-Speicher)
- **WW-Solltemperatur:** **`45 °C`**
- **Einschalt-Temp.differenz (Hysterese):** **`-6 °C`** *(vorher -5 °C; Nachladung startet bei 39 °C)*
- **Heizintervall (max.):** **`2:00 h`**
- **Warmwasser-Ladedauer (max.):** **`1:30 h`**
- **Entkeimung (Legionellenschaltung):** **`Aus`** (alle Wochentage deaktiviert)

---

## Zeitplan der Wärmpepumpe PV-optimiert (10 kWp ohne Batterie)

### Winter-Zeitplan (ab ca. Mitte Oktober)

| Tag         | Progr. | Uhrzeit | Status |    Modus    | Heizen  | Warmwasser |
| :---------- | :----: | :-----: | :----: | :---------: | :-----: | :--------: |
| **Mo – Fr** |   1    | `10:30` | `EIN`  | Heizen + WW | `+1 °C` |  `40 °C`   |
| **Mo – Fr** |   2    | `13:30` | `EIN`  | Heizen + WW | `+1 °C` |  `48 °C`   |
| **Mo – Fr** |   3    | `16:00` | `EIN`  | Heizen + WW | `-2 °C` |  `43 °C`   |
| **Sa – So** |   1    | `10:30` | `EIN`  | Heizen + WW | `+1 °C` |  `43 °C`   |
| **Sa – So** |   2    | `13:30` | `EIN`  | Heizen + WW | `+1 °C` |  `48 °C`   |
| **Sa – So** |   3    | `16:00` | `EIN`  | Heizen + WW | `-2 °C` |  `43 °C`   |


### Sommer-Zeitplan (ab ca. Mitte April)

| Tag         | Progr. | Uhrzeit | Status |    Modus    | Kühlen  | Warmwasser |
| :---------- | :----: | :-----: | :----: | :---------: | :-----: | :--------: |
| **Mo – Fr** |   1    | `10:00` | `EIN`  | Kühlen + WW | `18 °C` |  `40 °C`   |
| **Mo – Fr** |   2    | `14:30` | `EIN`  | Kühlen + WW | `18 °C` |  `48 °C`   |
| **Mo – Fr** |   3    | `18:00` | `EIN`  |   Nur WW    |  `Aus`  |  `43 °C`   |
| **Sa – So** |   1    | `10:00` | `EIN`  | Kühlen + WW | `18 °C` |  `43 °C`   |
| **Sa – So** |   2    | `14:30` | `EIN`  | Kühlen + WW | `18 °C` |  `48 °C`   |
| **Sa – So** |   3    | `18:00` | `EIN`  |   Nur WW    |  `Aus`  |  `43 °C`   |


## Urlaubseinstellungen nach Monat (10–14 Tage Abwesenheit)

| Monat         |     Heizbetrieb      |  Heizkurven-Verschiebung  | Kühlbetrieb | Warmwasser | Begründung / Hinweis                                                                                                   |
| :------------ | :------------------: | :-----------------------: | :---------: | :--------: | :--------------------------------------------------------------------------------------------------------------------- |
| **Januar**    |        `EIN`         |        **`-3 °C`**        |    `AUS`    |   `AUS`    | Frostschutz & Auskühlschutz; Ende 18 Stunden vor Rückkehr setzen                                                       |
| **Februar**   |        `EIN`         |        **`-3 °C`**        |    `AUS`    |   `AUS`    | Frostschutz & Auskühlschutz; Ende 18 Stunden vor Rückkehr setzen                                                       |
| **März**      |        `EIN`         |  **`-2 °C` bis `-3 °C`**  |    `AUS`    |   `AUS`    | Nächte oft noch frostig, tagsüber solare Gewinne; Ende 18 Stunden vor Rückkehr setzen                                  |
| **April**     |        `AUS`         |           `---`           |    `AUS`    |   `AUS`    | In einem 2020er Neubau meist schon komplett ohne Heizung möglich; Ende 6 Stunden vor Rückkehr setzen                   |
| **Mai**       |        `AUS`         |           `---`           |    `AUS`    |   `AUS`    | Nur Frostschutz aktiv; Speicher heizt am Rückreisetag in ca. 45–60 Min. auf; Ende 6 Stunden vor Rückkehr setzen        |
| **Juni**      |        `AUS`         |           `---`           |    `AUS`    |   `AUS`    | Keine aktive Kühlung bei Abwesenheit nötig (spart 100 % Kühlstrom); Ende 6 Stunden vor Rückkehr setzen                 |
| **Juli**      |        `AUS`         |           `---`           |    `AUS`    |   `AUS`    | Keine aktive Kühlung bei Abwesenheit nötig (spart 100 % Kühlstrom); Ende 6 Stunden vor Rückkehr setzen                 |
| **August**    |        `AUS`         |           `---`           |    `AUS`    |   `AUS`    | Keine aktive Kühlung bei Abwesenheit nötig (spart 100 % Kühlstrom); Ende 6 Stunden vor Rückkehr setzen                 |
| **September** |        `AUS`         |           `---`           |    `AUS`    |   `AUS`    | Hohe gespeicherte Restwärme im gedämmten Haus verhindert Auskühlen; Ende 6 Stunden vor Rückkehr setzen                 |
| **Oktober**   | `AUS` *(oder `EIN`)* | **`-3 °C`** *(falls Ein)* |    `AUS`    |   `AUS`    | Anfang Oktober reicht `AUS`, ab Ende Oktober sanft mit `-3 °C` durchlaufen lassen; Ende 18 Stunden vor Rückkehr setzen |
| **November**  |        `EIN`         |        **`-3 °C`**        |    `AUS`    |   `AUS`    | Verhindert starkes Auskühlen des Estrichs; Ende 18 Stunden vor Rückkehr setzen                                         |
| **Dezember**  |        `EIN`         |        **`-3 °C`**        |    `AUS`    |   `AUS`    | Frostschutz & Auskühlschutz; Ende 18 Stunden vor Rückkehr setzen                                                       |
