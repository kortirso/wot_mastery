window.components.filter = () => {
  return {
    isOpen: false,
    countries: [],
    types: [],
    tiers: [],
    tanks: [],
    tanksList: [],
    sortField: '',
    sortOrder: 1,
    openedTank: 0,
    currentTankValues: {
      damage: 0,
      kill: 0,
      assist: 0,
      block: 0,
      stun: 0
    },
    tankCoefficientModifiers: [5, 4, 1, 0],
    spgCoefficientModifiers: [5, 0, 0, 5],
    toggle() { this.isOpen = !this.isOpen },
    toggleFilter(type, value) {
      let collection = this[type]
      if (collection.includes(value)) {
        const valueIndex = collection.indexOf(value)
        collection.splice(valueIndex, 1)
      } else collection.push(value)
      this[type] = collection
    },
    resetFilters() {
      this.countries = []
      this.types = []
      this.tiers = []
      this.tanks = []
    },
    apply() {
      const params = []
      if (this.countries.length > 0) {
        const countries = this.countries.join(',')
        params.push(`country_ids=${countries}`)
      }
      if (this.types.length > 0) {
        const types = this.types.join(',')
        params.push(`type_ids=${types}`)
      }
      if (this.tiers.length > 0) {
        const tiers = this.tiers.join(',')
        params.push(`tiers=${tiers}`)
      }
      if (this.tanks.length > 0) {
        const tanks = this.tanks.join(',')
        params.push(`tank_ids=${tanks}`)
      }
      fetch(`/api/v1/tanks.json?${params.join('&')}`)
        .then(response => response.json())
        .then(json => { this.tanksList = json.tanks.data })
      this.isOpen = false
    },
    sortBy(field) {
      if (field === this.sortField) this.sortOrder = -this.sortOrder
      else {
        this.sortField = field
        this.sortOrder = 1
      }
      this.tanksList.sort((a, b) => this.sortOrder * (a.attributes[field] - b.attributes[field]))
    },
    toggleOpenedTank(value) {
      const selectedTank = this.tanksList.filter((tank) => {
        return tank.id === value
      })[0]
      if (selectedTank === this.openedTank) this.openedTank = 0
      else {
        this.openedTank = selectedTank
        this.currentTankValues = {
          damage: 0,
          kill: 0,
          assist: 0,
          block: 0,
          stun: 0
        }
      }
    },
    changeInput({ target }) {
      const coefficients = this.openedTank.attributes.experience_coefficient.data.attributes
      const masterExperience = this.openedTank.attributes.master_grade_boundary
      const needExperience = (masterExperience - (parseInt(target.value) * coefficients.damage + coefficients.bonus) / 1000) / 10

      let coefficientModifiers
      if (this.openedTank.attributes.type === 'spg') coefficientModifiers = this.spgCoefficientModifiers
      else coefficientModifiers = this.tankCoefficientModifiers

      this.currentTankValues = {
        damage: parseInt(target.value),
        kill: Math.round(coefficientModifiers[0] * needExperience / coefficients.kill),
        assist: Math.round(coefficientModifiers[1] * 1000 * needExperience / coefficients.assist),
        block: Math.round(coefficientModifiers[2] * 1000 * needExperience / coefficients.block),
        stun: Math.round(coefficientModifiers[3] * 1000 * needExperience / coefficients.stun)
      }
    }
  }
}
