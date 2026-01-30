\# Multi‑Platform Launcher (Flutter + Riverpod)



Launcher cross‑platform ispirato a un progetto web/Capacitor esistente, con:



\- Android / iOS / Web / Desktop

\- Drag \& drop delle icone

\- Pinch‑zoom (solo in edit mode)

\- Context menu (rename / change icon / remove)

\- Storage criptato (AES)

\- Ordine icone persistente

\- Apertura URL come app esterna

\- Setup iniziale (URL, user, password)

\- Help page (markdown)



---



\## Struttura del progetto



```text

lib/

&nbsp; main.dart



&nbsp; models/

&nbsp;   app\_model.dart

&nbsp;   config\_model.dart



&nbsp; services/

&nbsp;   api\_service.dart

&nbsp;   storage\_service.dart

&nbsp;   launcher\_service.dart



&nbsp; controllers/

&nbsp;   launcher\_controller.dart

&nbsp;   zoom\_controller.dart

&nbsp;   drag\_controller.dart

&nbsp;   edit\_controller.dart

&nbsp;   context\_menu\_controller.dart

&nbsp;   config\_controller.dart



&nbsp; pages/

&nbsp;   setup\_page.dart

&nbsp;   launcher\_page.dart

&nbsp;   help\_page.dart



&nbsp; widgets/

&nbsp;   app\_icon.dart

&nbsp;   app\_grid.dart

&nbsp;   context\_menu.dart

&nbsp;   rename\_dialog.dart

&nbsp;   zoom\_wrapper.dart



&nbsp; utils/

&nbsp;   image\_utils.dart



