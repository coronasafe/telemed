let select = (setPrescription, prescription) => setPrescription(_ => prescription);

[@react.component]
let make = (~prescriptions) => {
  let (prescriptions, setPrescriptions) = React.useState(_ => prescriptions);
  <div>
      <Prescription__Builder prescriptions={prescriptions} selectCB={select(setPrescriptions)}/>
      <input className="hidden" name="prescription[medicines]" value={Json.stringify(prescriptions |> Prescription__Prescription.encodeArray)}/>
  </div>
};