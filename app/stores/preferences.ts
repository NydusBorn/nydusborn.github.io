import {defineStore} from 'pinia'
import {useLocalStorage} from "@vueuse/core";

export const usePreferenceStore = defineStore('preferences', () => {
  const preferences = useLocalStorage('preferences',
    {
    },
    {
      mergeDefaults: true
    })
  return {preferences}
})
