# IOS_GymApp

# 💪 Scheda Allenamento

Scheda Allenamento è un'app iOS creata per uso personale che consente di organizzare, monitorare e completare i propri allenamenti in modo semplice, intuitivo e completamente offline.

## 📱 Caratteristiche principali

- **Visualizzazione degli allenamenti**: suddivisione in schede (dorso/bicipiti, petto/tricipiti, gambe/spalle) con esercizi dettagliati.
- **Esercizi con immagini animate (GIF)**: ogni esercizio è corredato da una GIF dimostrativa.
- **Timer integrato** per tenere traccia del tempo di allenamento.
- **Check-off degli esercizi** per segnare quelli completati durante la sessione.
- **Reset automatico** degli esercizi completati (opzionale).
- **Tema e colore personalizzabili**: chiaro, scuro o automatico, con più scelte cromatiche.
- **Design nativo SwiftUI**: interfaccia elegante, moderna e responsive.

## 🧠 Filosofia dell'app

L'app è stata progettata con un obiettivo: aiutare l'utente a concentrarsi sull'allenamento, riducendo al minimo le distrazioni. Non ci sono notifiche invasive, tracking online o richieste di login. Solo te, la tua scheda e la tua forza di volontà.

## 🔧 Tecnologie utilizzate

- **SwiftUI** per l'interfaccia grafica
- **AppStorage** per le preferenze utente
- **UserDefaults + Codable** per il salvataggio dello stato degli esercizi
- **CoreData** (già integrato per espandibilità futura)
- **SDWebImageSwiftUI** per la gestione delle immagini animate (GIF)

## 🚀 Future implementazioni

- ✅ **Aggiunta di nuovi esercizi direttamente dall'app**, senza modificare il codice.
- 📷 **Scansione automatica di una scheda cartacea**, con estrazione intelligente degli esercizi.
- ⏱️ **Timer per il recupero** tra una serie e l’altra.
- 📝 **Sezione note personalizzate per ogni esercizio**, per annotazioni o suggerimenti personali.

## 📂 Cartella GIF

All'interno della cartella `SchedaAllenamento/`ci sarebbe dovuta esserci la cartella `gif/`, utilizzata dall’app per mostrare immagini animate nella sezione info ad ogni esercizio.
Seppur i riferimenti alle gif sono stati conservati nel file ContenView.swift, la Cartella non è stata pubblicata per evitare problemi di copyright.  
L’utente può aggiungere manualmente le GIF desiderate nel progetto Xcode, rispettando le licenze d’uso.

## 🎯 Obiettivo

Questa app è stata creata per uso personale e non è destinata alla pubblicazione su App Store (almeno per ora). 
È pensata come strumento di supporto per il personale allenamento.

