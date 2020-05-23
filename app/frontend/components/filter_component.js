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
    }
  }
}
