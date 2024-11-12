#!/bin/bash

# Дефинисање почетног датума рада (28.10.2024. - Непарна недеља)
pocetak_rada="2024-10-28"

# Претварање тренутног датума у формат ГГГГ-ММ-ДД
datum_danas=$(date +%Y-%m-%d)

# Израчунавање разлике у данима између данашњег датума и почетка рада
razlika_dana=$(( ( $(date -d "$datum_danas" +%s) - $(date -d "$pocetak_rada" +%s) ) / 86400 ))

# Израчунавање разлике у недељама (7 радних дана)
razlika_nedelja=$(( razlika_dana / 7 ))

# Израчунавање почетка тренутне радне недеље
pocetak_tekuca_nedelja=$(date -d "$pocetak_rada + $((razlika_nedelja * 7)) days" "+%d. %B")
dan_pocetak=$(date -d "$pocetak_rada + $((razlika_nedelja * 7)) days" "+%A")

# Израчунавање краја тренутне радне недеље (6 дана након почетка)
kraj_tekuca_nedelja=$(date -d "$pocetak_rada + $((razlika_nedelja * 7 + 6)) days" "+%d. %B")
dan_kraj=$(date -d "$pocetak_rada + $((razlika_nedelja * 7 + 6)) days" "+%A")

# Израчунавање имена дана за данашњи датум
dan_danas=$(date -d "$datum_danas" "+%A")

# Боје
crvena='\033[0;31m'    # Црвена
plava='\033[0;34m'     # Плава
zelena='\033[0;32m'    # Зелена
zuta='\033[1;33m'      # Жута
reset='\033[0m'        # Ресетовање боје

# Провера да ли је разлика у недељама парна или непарна и додавање боје
# Непарна недеља треба да буде означена као ❄️ и плава
if (( (razlika_nedelja + 1) % 2 == 0 )); then
    nedelja_tip="${crvena}🗼 Парна недеља${reset}"
else
    nedelja_tip="${plava}❄️ Непарна недеља${reset}"
fi

# Испис периода тренутне недеље
echo -e "Тренутна недеља траје од ${zelena}☀️ $dan_pocetak, $pocetak_tekuca_nedelja${reset} до ${zelena}🌙 $dan_kraj, $kraj_tekuca_nedelja.${reset}"

# Испис датума
echo -e "Датум ${zuta}🗓️ $dan_danas, $(date "+%d. %B %Y.") ${reset}је $nedelja_tip."
