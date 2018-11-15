export const command = "bash ./PRsRequested.widget/helper.sh";

export const refreshFrequency = 5000; // ms

export const updateState = (event, previousState) => {
  if (event.error) {
    return { ...previousState, warning: `We got an error: ${event.error}` };
  }
  const [Title, Url, Status] = event.output.split('#');
  return {
    Title,
    Url,
    Status
  };
}

export const render = ({Title, Url, Status, error}) => {
  const isPassing = Status.trim() === 'success';
  const isPending = Status.trim() === 'pending';
  return error ?
  (
    <div>Something went wrong: <strong>{String(error)}</strong></div>
  ) :
  (
    <div>
      <div className={header}>Requested Pull Request Reviews</div>
      <div className={(function() {
        switch(Status.trim()) {
          case 'success':
            return passTitle;
          case 'pending':
            return pendTitle;
          default:
            return failTitle;
        }
      })()}>{Title}</div>
      <div className={url}><a href={Url}>{Url}</a></div>
    </div>
  );
}

export const className = {
  top: 10,
  left: 10,
  color: '#fff'
}

import { css } from "uebersicht"

const header = css`
  font-family: Helvetica Neue;
  text-transform: uppercase;
  font-size: 14px;
  text-align: center;
  color: white;
`

const passTitle = css`
  font-family: Helvetica Neue;
  text-transform: uppercase;
  font-weight: bold;
  color: #22FF22;
  font-size: 10px;
`

const pendTitle = css`
  font-family: Helvetica Neue;
  text-transform: uppercase;
  font-weight: bold;
  color: #FFFF22;
  font-size: 10px;
`

const failTitle = css`
  font-family: Helvetica Neue;
  text-transform: uppercase;
  font-weight: bold;
  color: #FF2222;
  font-size: 10px;
`

const url = css`
  font-family: Helvetica Neue;
  text-transform: uppercase;
  padding-left: 5px;
  font-size: 10px;
  a {
   color: white;
  }
`
