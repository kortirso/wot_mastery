window.components.filter = () => {
  return {
    isOpen: false,
    countries: [],
    types: [],
    tiers: [],
    tanks: [],
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
      const params = this.tanks.join(',')
      fetch(`/tanks.html?tank_ids=${params}`)
        .then(response => response.text())
        .then(html => { this.$refs.tanks.innerHTML = html })
      this.isOpen = false
    }
  }
}
