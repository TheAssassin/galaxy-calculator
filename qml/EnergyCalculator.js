/* ****************************************************************************
 *  calc Energy
 * f = fire resonant frequency: int
 * x = current value of frequency: int
 * Energy in Frequency: int
 */
function calcEnergy(f, x) {
    setEnergy( humanize(f - (f - x)) );
    setEnergyFormula( humanize(f) + " - (  " + humanize(f) + " - " + humanize(x) + " )");
}
/* ****************************************************************************
 * Energy
 */
var Energy = 0.0;
function getEnergy() {
    return Energy;
}
function setEnergy(energy) {
    Energy = energy;
}
/* ****************************************************************************
 * EnergyFormula
 */
var EnergyFormula = "";
function getEnergyFormula() {
    return EnergyFormula;
}
function setEnergyFormula(energyFormula) {
    EnergyFormula = energyFormula;
}
