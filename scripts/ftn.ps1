# Дефинисање почетног датума рада (01.10.2024.)
$pocetak_rada = Get-Date "2024-10-01"

# Претварање тренутног датума у формат ГГГГ-ММ-ДД
$datum_danas = Get-Date

# Израчунавање разлике у данима између данашњег датума и почетка рада
$razlika_dana = ($datum_danas - $pocetak_rada).Days

# Израчунавање разлике у недељама (6 радних дана)
$razlika_nedelja = [math]::Floor($razlika_dana / 6)

# Израчунавање почетка тренутне радне недеље
$pocetak_tekuca_nedelja = $pocetak_rada.AddDays($razlika_nedelja * 6).ToString("dd. MMMM")
$dan_pocetak = $pocetak_rada.AddDays($razlika_nedelja * 6).ToString("dddd")

# Израчунавање краја тренутне радне недеље (5 дана након почетка)
$kraj_tekuca_nedelja = $pocetak_rada.AddDays($razlika_nedelja * 6 + 5).ToString("dd. MMMM")
$dan_kraj = $pocetak_rada.AddDays($razlika_nedelja * 6 + 5).ToString("dddd")

# Израчунавање имена дана за данашњи датум
$dan_danas = $datum_danas.ToString("dddd")

# Провера да ли је разлика у недељама парна или непарна и додавање текста
if ($razlika_nedelja % 2 -eq 0) {
    $nedelja_tip = "❄️ Непарна недеља"
} else {
    $nedelja_tip = "🗼 Парна недеља"
}

# Испис периода тренутне недеље
Write-Host "Тренутна недеља траје од ☀️ $dan_pocetak, $pocetak_tekuca_nedelja до 🌙 $dan_kraj, $kraj_tekuca_nedelja."

# Испис датума
Write-Host "Датум 🗓️ $dan_danas, $($datum_danas.ToString('dd. MMMM yyyy.')) је $nedelja_tip."
